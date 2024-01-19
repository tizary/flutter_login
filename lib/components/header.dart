import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String pageTitle;

  const Header({super.key, required this.pageTitle});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      title: Text(
        pageTitle,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
