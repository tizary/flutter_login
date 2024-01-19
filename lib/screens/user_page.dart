import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/burger_menu.dart';
import 'package:flutter_application_1/components/header.dart';
import 'package:flutter_application_1/routes/app_routes.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  int _currentWidget = 0;
  List<Widget> widgets = const [
    MainWidget(),
    Icon(Icons.business),
    Icon(Icons.currency_exchange_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: const Header(pageTitle: 'User'),
      drawer: const BurgerMenu(),
      body: widgets[_currentWidget],
      bottomNavigationBar: BottomNavigationBar(
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
            icon: Icon(Icons.business),
            label: 'Business',
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

class MainWidget extends StatefulWidget {
  const MainWidget({
    super.key,
  });

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  bool isSwitch = false;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              ListOfTilesWidget(
                iconLeading: Icons.account_box_rounded,
                text: 'Profile',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.userProfilePage);
                },
              ),
              const Divider(),
              ListOfTilesWidget(
                iconLeading: Icons.account_balance_wallet,
                text: 'Wallet',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.userWalletPage);
                },
              ),
              const Divider(),
              ListOfTilesWidget(
                iconLeading: Icons.add_location_rounded,
                text: 'Location',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.userLocationPage);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.audiotrack_rounded,
                  size: 32,
                ),
                title: const Text(
                  'Sounds',
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Switch(
                    value: isSwitch,
                    onChanged: (value) {
                      setState(() {
                        isSwitch = value;
                      });
                    }),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ListOfTilesWidget extends StatelessWidget {
  final IconData iconLeading;
  final String text;
  final VoidCallback onTap;

  const ListOfTilesWidget({
    super.key,
    required this.iconLeading,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconLeading,
        size: 32,
      ),
      title: Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
