import 'package:flutter/material.dart';

import '../../components/header.dart';

class UserLocationPageWidget extends StatelessWidget {
  const UserLocationPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Header(pageTitle: 'Location'),
      body: Center(
          child: Text(
        'Location',
        style: TextStyle(fontSize: 20),
      )),
    );
  }
}
