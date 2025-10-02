import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:login_page/DashBoard.dart';
import 'package:login_page/SignInPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  //initilize apps
  WidgetsFlutterBinding.ensureInitialized();
  //stores data as tokens
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(token: prefs.getString('token'))); //used to get token from app
}

class MyApp extends StatelessWidget {
  final token;
  const MyApp({Key? key, @required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //if token is expired send user back to login page otherwise dashboard
      home: (token != null && JwtDecoder.isExpired(token) == false)
          ? Dashboard(token: token)
          : SignInPage(),
    );
  }
}
