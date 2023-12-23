import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/header.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(pageTitle: 'User'),
        backgroundColor: Color.fromARGB(255, 99, 149, 229),
        body: Center(
            child: Text('User info',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 44,
                    fontWeight: FontWeight.bold))));
  }
}
