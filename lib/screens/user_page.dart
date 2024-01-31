import 'package:flutter/material.dart';
import '../components/burger_menu.dart';
import '../components/header.dart';
import 'issues_page_widget.dart';
import 'user_page_widgets/exchange_rates_widget.dart';
import 'user_page_widgets/main_user_page_widget.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _controller = PageController();
  int _currentWidget = 0;
  int _currentBottomItem = 0;

  List<Widget> widgets = const [
    MainUserPageWidget(),
    IssuesPageWidget(),
    ExchangeRatesWidget(),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: const Header(pageTitle: 'User'),
      drawer: const BurgerMenu(),
      // body: widgets[_currentWidget],
      body: PageView(
        controller: _controller,
        children: const [
          MainUserPageWidget(),
          IssuesPageWidget(),
          ExchangeRatesWidget(),
        ],
        onPageChanged: (value) {
          setState(() {
            _currentWidget = value;
            _currentBottomItem = value;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.white,
        unselectedItemColor: Colors.white60,
        backgroundColor: Colors.blue,
        currentIndex: _currentBottomItem,
        onTap: (int newIndex) {
          setState(() {
            _currentBottomItem = newIndex;
            _controller.jumpToPage(newIndex);
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
