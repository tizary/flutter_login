import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/burger_menu.dart';
import 'package:flutter_application_1/components/header.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    final userData = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
        appBar: Header(pageTitle: 'User'),
        drawer: BurgerMenu(user: userData),
        body: Center(child: Text('hello')));
  }
}
