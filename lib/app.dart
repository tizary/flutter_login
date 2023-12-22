import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_page.dart';
import 'package:flutter_application_1/screens/login_page.dart';
import 'package:flutter_application_1/screens/register_page.dart';
import 'package:flutter_application_1/screens/user_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: HomePage(),
      routes: {
        'login': (context) => LoginPage(),
        'register': (context) => RegisterPage(),
        'user':(context) => UserPage()
      }
    );
  }
}