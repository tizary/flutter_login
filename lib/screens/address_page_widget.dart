import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/header.dart';

class AddressPageWidget extends StatelessWidget {
  const AddressPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(pageTitle: 'Address'),
      body: Text('address'),
    );
  }
}