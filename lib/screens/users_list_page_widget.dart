import 'package:flutter/material.dart';
import 'package:flutter_application_1/server/mongodb.dart';
import 'package:flutter_application_1/components/header.dart';

class UsersListPageWidget extends StatefulWidget {
  const UsersListPageWidget({super.key});

  @override
  State<UsersListPageWidget> createState() => _UsersListPageWidgetState();
}

class _UsersListPageWidgetState extends State<UsersListPageWidget> {
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

    var usersDb = await MongoDatabase.getUsers();
    setState(() {
      users = usersDb;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var textStyleHeader = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);

    return Scaffold(
        appBar: Header(pageTitle: 'Users data list'),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Table(
                  border: TableBorder.all(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey),
                  children: [
                    TableRow(children: [
                      Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Text(
                            'Email',
                            style: textStyleHeader,
                          )),
                      Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Text(
                            'User',
                            style: textStyleHeader,
                          )),
                    ]),
                    ...users.map((item) {
                      return TableRow(children: [
                        Container(
                            padding: EdgeInsets.all(10),
                            child: Text(item['email'])),
                        Container(
                            padding: EdgeInsets.all(10),
                            child: Text(item['userName']))
                      ]);
                    }).toList()
                  ],
                )));
  }
}
