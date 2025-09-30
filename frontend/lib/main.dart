import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:login_page/DashBoard.dart';
import 'package:login_page/Register.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  //initilize apps
  WidgetsFlutterBinding.ensureInitialized();
  //stores data as tokens
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(tokens: prefs.getString('token'))); //used to get token from app
}

class MyApp extends StatelessWidget {
  final tokens;
  const MyApp({Key? key, this.tokens}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (tokens != null && JwtDecoder.isExpired(tokens) == false)
          ? Dashboard()
          : Register(),
    );
  }
}
