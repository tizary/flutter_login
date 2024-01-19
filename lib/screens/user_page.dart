import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/burger_menu.dart';
import 'package:flutter_application_1/components/header.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: Header(pageTitle: 'User'),
        drawer: BurgerMenu(),
        body: Center(child: Text('hello')));
  }
}
