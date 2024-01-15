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

    var usersDb = await MongoDatabase.getUsers();
    setState(() {
      users = usersDb;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    // usersDb?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textStyleHeader = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);

    return Scaffold(
        appBar: Header(pageTitle: 'Main'),
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
