import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../components/header.dart';

class UserWalletPageWidget extends StatelessWidget {
  const UserWalletPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Header(pageTitle: 'Wallet'),
      body: Center(
          child: Text(
        'Wallet',
        style: TextStyle(fontSize: 20),
      )),
    );
  }
}
