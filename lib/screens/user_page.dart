import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/burger_menu.dart';
import 'package:flutter_application_1/components/header.dart';

import 'issues_page_widget.dart';
import 'user_page_widgets/exchange_rates_widget.dart';
import 'user_page_widgets/main_user_page_widget.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  int _currentWidget = 0;
  List<Widget> widgets = const [
    MainUserPageWidget(),
    IssuesPageWidget(),
    ExchangeRatesWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: const Header(pageTitle: 'User'),
      drawer: const BurgerMenu(),
      body: widgets[_currentWidget],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.white,
        unselectedItemColor: Colors.white60,
        backgroundColor: Colors.blue,
        currentIndex: _currentWidget,
        onTap: (int newIndex) {
          setState(() {
            _currentWidget = newIndex;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Main',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.electric_bolt),
            label: 'Issues',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_exchange_outlined),
            label: 'Exchange Rates',
          ),
        ],
      ),
    );
  }
}
