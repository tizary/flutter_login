import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/routes/app_routes.dart';
import 'package:flutter_application_1/state/app_state.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user.dart';

class BurgerMenu extends StatefulWidget {
  const BurgerMenu({super.key});

  @override
  State<BurgerMenu> createState() => _BurgerMenuState();
}

class _BurgerMenuState extends State<BurgerMenu> {
  final User user = AppState.userStore;

  List<String> menu = [
    'Registered Users',
    'Contacts info',
    'Phone contacts',
    'Gallery',
    'Address',
  ];
  List<String> path = [
    AppRoutes.usersListPage,
    AppRoutes.contactsInfoPage,
    AppRoutes.phoneContactsPage,
    AppRoutes.galleryPage,
    AppRoutes.addressPage,
  ];

  File? _imageFile;

  Future<void> _getImage(source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imagePath = File(image.path);
      setState(() {
        _imageFile = imagePath;
      });
    } on PlatformException catch (e) {
      print('Falied to pick image: $e');
    }
  }

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(16),
            height: 150,
            child: Row(children: [
              Expanded(
                child: InkWell(
                    onTap: () {
                      _getImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    child: const Column(
                      children: [
                        Icon(Icons.image, size: 60),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Gallery',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    )),
              ),
              Expanded(
                child: InkWell(
                    onTap: () {
                      _getImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    child: const Column(
                      children: [
                        Icon(Icons.photo_camera, size: 60),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Camera',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    )),
              ),
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // final userName = widget.user.userName;
    final userName = user.userName;
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: 200,
            child: DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Column(
                children: [
                  GestureDetector(
                      onTap: () {
                        showImagePicker(context);
                      },
                      child: _imageFile == null
                          ? const Icon(
                              Icons.account_circle_sharp,
                              size: 100,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(
                                _imageFile!,
                                height: 100,
                                width: 100,
                                fit: BoxFit.fill,
                              ),
                            )),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(userName,
                      style: const TextStyle(color: Colors.white, fontSize: 20))
                ],
              ),
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
