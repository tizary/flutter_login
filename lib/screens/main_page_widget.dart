import 'package:flutter/material.dart';
import 'package:flutter_application_1/mongodb.dart';
import 'package:flutter_application_1/screens/header.dart';

class MainPageWidget extends StatefulWidget {
  const MainPageWidget({super.key});

  @override
  State<MainPageWidget> createState() => _MainPageWidgetState();
}

class _MainPageWidgetState extends State<MainPageWidget> {
  bool _isLoading = false;
  List<Map> users = [];
  @override
  void initState() {
    getUsersList();
    super.initState();
  }

  Future getUsersList() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));

    var usersDb = await MongoDatabase.getUsers();
    setState(() {
      users = usersDb;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(pageTitle: 'Main'),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: DataTable(
                      border: TableBorder.all(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)),
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
              ));
  }
}
