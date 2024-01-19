import 'package:flutter/material.dart';

import '../../components/header.dart';

class UserProfilePageWidget extends StatelessWidget {
  const UserProfilePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Header(pageTitle: 'Profile'),
      body: Center(
          child: Text(
        'Profile',
        style: TextStyle(fontSize: 20),
      )),
    );
  }
}
