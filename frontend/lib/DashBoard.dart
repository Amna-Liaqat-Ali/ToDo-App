import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

import 'config.dart';

class Dashboard extends StatefulWidget {
  //accepts token from login page
  final token;
  const Dashboard({@required this.token, super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //takes user id from user controller file(backend) passed in token
  late String userId;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  //generating list in frontend
  List items = [];

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    getToDoList(userId);
  }

  //get all to do lists in app
  void getToDoList(userId) async {
    var regBody = {
      "userId": userId,
      "title": titleController.text,
      "desc": descController.text,
    };

    try {
      var response = await http.post(
        Uri.parse(getList),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );
      var jsonResponse = jsonDecode(response.body);
      items = jsonResponse['success'];
    } catch (e) {
      print("Error: $e");
    }
  }

  //takes data from fields nd send back to backend
  void AddToDo() async {
    if (titleController.text.isNotEmpty && descController.text.isNotEmpty) {
      var regBody = {
        "userId": userId,
        "title": titleController.text,
        "desc": descController.text,
      };

      try {
        var response = await http.post(
          Uri.parse(addToDo),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody),
        );
        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status']) {
          titleController.clear();
          descController.clear();
          Navigator.pop(context);
        } else {
          print('Something went wrong');
        }
      } catch (e) {
        print("Error: $e");
      }
    }
  }

  // Function to show Add To-Do dialog
  void _showAddTodoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add To-Do"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                AddToDo();
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 4,
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "ToDo with NodeJS + MongoDB",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            "Welcome: $userId",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            "${items.length} Task",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(items[index]),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.redAccent,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      items.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Item deleted")),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.teal,
                      ),
                      title: Text(
                        '${items![index]['title']}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        '${items![index]['desc']}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTodoDialog,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
