import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_page/SignInPage.dart';

import 'config.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => RegisterState();
}

class RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isValid = false;

  //takes data from fields nd send back to backend
  void registerUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      //object for passing data in backend
      var regBody = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      try {
        //sending through post api to our localhost(regsiter)
        var response = await http.post(
          Uri.parse(regsiter), // example: "http://10.0.2.2:3000/register"
          //what kind of data sendind to backend
          headers: {
            "Content-Type": "application/json", // must be inside http.post()
          },
          // convert map to JSON string(bcz object direcly can't be send)
          body: jsonEncode(regBody), // convert map -> JSON string
        );

        print("STATUS: ${response.statusCode}");
        print("BODY: ${response.body}");

        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse['status'] == true) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignInPage()),
          );
        } else {
          print("Something went wrong");
        }
      } catch (e) {
        print("Error: $e");
      }
    } else {
      setState(() {
        _isValid = true;
      });
    }
  }

  void signIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.white],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Register',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Email",
                        errorText: _isValid ? "Enter required field" : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        errorText: _isValid ? "Enter required field" : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        registerUser();
                      },
                      child: Text("Register"),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text("Already have an account?"),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextButton(
                      onPressed: () {
                        signIn();
                      },
                      child: Text("Sign in"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
