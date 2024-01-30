import 'package:flutter/material.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

import '../components/header.dart';

class PhoneContactsPageWidget extends StatefulWidget {
  const PhoneContactsPageWidget({super.key});

  @override
  State<PhoneContactsPageWidget> createState() =>
      _PhoneContactsPageWidgetState();
}

class _PhoneContactsPageWidgetState extends State<PhoneContactsPageWidget> {
  Future<List> getContacts() async {
    bool isGranted = await Permission.contacts.status.isGranted;
    if (!isGranted) {
      isGranted = await Permission.contacts.request().isGranted;
    }
    if (isGranted) {
      return await FastContacts.getAllContacts();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(pageTitle: 'Phone contacts'),
      body: FutureBuilder(
          future: getContacts(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData || snapshot.data.isEmpty) {
              return const Center(child: Text('No contacts'));
            }
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  var contact = snapshot.data[index];
                  return Column(
                    children: [
                      Text(contact.displayName),
                      Column(
                        children: [
                          for (var phone in contact.phones) Text(phone.number),
                        ],
                      ),
                      const Divider(),
                    ],
                  );
                });
          }),
    );
  }
}
