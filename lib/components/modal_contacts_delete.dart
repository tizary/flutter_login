import 'package:flutter/material.dart';

class ModalContactsDelete extends StatelessWidget {
  final Function onYesPressed;

  const ModalContactsDelete({super.key, required this.onYesPressed});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Attention'),
      content: const Text('Do you want to delete the user?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            onYesPressed();
            Navigator.of(context).pop();
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
