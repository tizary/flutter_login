import 'package:flutter/material.dart';

class BurgerMenu extends StatefulWidget {
  const BurgerMenu({super.key});

  @override
  State<BurgerMenu> createState() => _BurgerMenuState();
}

class _BurgerMenuState extends State<BurgerMenu> {
  @override
  Widget build(BuildContext context) {
    List<String> menu = [
      'Main',
      'Contacts',
      'Products',
      'Gallery',
      'Address',
    ];
    List<String> path = [
      'main_page',
      'contacts_page',
      'products_page',
      'gallery_page',
      'address_page',
    ];
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              children: [
                Icon(
                  Icons.account_circle_sharp,
                  size: 50,
                ),
                SizedBox(
                  height: 20,
                ),
                Text('user name',
                    style: TextStyle(color: Colors.white, fontSize: 20))
              ],
            ),
          ),
          ...menu.map((elem) {
            var index = menu.indexOf(elem);
            return Column(children: [
              ListTile(
                title: Text(
                  elem,
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.pushNamed(context, path[index]);
                },
              ),
              Divider()
            ]);
          }),
        ],
      ),
    );
  }
}
