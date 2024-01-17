import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/app_routes.dart';

class BurgerMenu extends StatefulWidget {
  final String user;
  BurgerMenu({Key? key, required this.user});

  @override
  State<BurgerMenu> createState() => _BurgerMenuState();
}

class _BurgerMenuState extends State<BurgerMenu> {
  @override
  Widget build(BuildContext context) {
    List<String> menu = [
      'Users data list',
      'Contacts info',
      'Phone contacts',
      'Gallery',
      'Address',
    ];
    List<String> path = [
      AppRoutes.userListPage,
      AppRoutes.contactsInfoPage,
      AppRoutes.phoneContactsPage,
      AppRoutes.galleryPage,
      AppRoutes.addressPage,
    ];
    final userName = widget.user.split('@').first;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Column(
              children: [
                const Icon(
                  Icons.account_circle_sharp,
                  size: 50,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(userName,
                    style: const TextStyle(color: Colors.white, fontSize: 20))
              ],
            ),
          ),
          ...menu.map((elem) {
            var index = menu.indexOf(elem);
            return Column(children: [
              ListTile(
                title: Text(
                  elem,
                  style: const TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.pushNamed(context, path[index]);
                },
              ),
              const Divider()
            ]);
          }),
        ],
      ),
    );
  }
}
