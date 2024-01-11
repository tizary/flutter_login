import 'package:flutter/material.dart';
import 'package:flutter_application_1/mongodb.dart';
import 'package:flutter_application_1/screens/header.dart';

class MainPageWidget extends StatefulWidget {
  const MainPageWidget({super.key});

  @override
  State<MainPageWidget> createState() => _MainPageWidgetState();
}

class _MainPageWidgetState extends State<MainPageWidget> {
  List<Map> users = [];
  @override
  void initState() {
    getUsersList();
    super.initState();
  }

  Future getUsersList() async {
    var usersDb = await MongoDatabase.getUsers();
    setState(() {
      users = usersDb;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(pageTitle: 'Main'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: DataTable(
              border: TableBorder.all(
                  color: Colors.grey, borderRadius: BorderRadius.circular(10)),
              columns: const [
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('User')),
              ],
              rows: users
                  .map((elem) => DataRow(cells: [
                        DataCell(Text(elem['email'])),
                        DataCell(Text(elem['user'])),
                      ]))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
