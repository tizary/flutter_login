import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/header.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(pageTitle: 'User'),
        body: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Text('User info')));
  }
}
