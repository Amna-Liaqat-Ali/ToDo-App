import 'package:flutter/material.dart';
import 'package:login_page/SignInPage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  void SignOut() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Congrulations,Our app is working",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () => SignOut(), child: Text("Sign Out")),
          ],
        ),
      ),
    );
  }
}
