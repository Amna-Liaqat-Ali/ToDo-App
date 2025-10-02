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

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
  }

  //takes data from fields nd send back to backend
  void AddToDo() async {
    if (titleController.text.isNotEmpty && descController.text.isNotEmpty) {
      //object for passing data in backend
      var regBody = {
        "userId": userId,
        "title": titleController.text,
        "desc": descController.text,
      };

      try {
        //sending through post api to our localhost(regsiter)
        var response = await http.post(
          Uri.parse(addToDo),
          //what kind of data sendind to backend
          headers: {
            "Content-Type": "application/json", // must be inside http.post()
          },
          // convert map to JSON string(bcz object direcly can't be send)
          body: jsonEncode(regBody), // convert map -> JSON string
        );
        var jsonResponse = jsonDecode(response.body);

        print(jsonResponse['status']);

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
                Navigator.pop(context); // close dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                String title = titleController.text.trim();
                String desc = descController.text.trim();
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Welcome: $userId")],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTodoDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
