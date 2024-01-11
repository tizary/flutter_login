import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_info.dart';
import 'package:flutter_application_1/screens/header.dart';
import 'package:intl/intl.dart';

import '../mongodb.dart';

class ContactsPageWidget extends StatefulWidget {
  const ContactsPageWidget({super.key});

  @override
  State<ContactsPageWidget> createState() => _ContactsPageWidgetState();
}

class _ContactsPageWidgetState extends State<ContactsPageWidget> {
  List<Map> users = [];
  String sex = 'male';
  bool isChecked = false;

  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  TextEditingController _date = TextEditingController();

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  void resetFields() {
    _emailController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _date.clear();
    setState(() {
      sex = 'male';
      isChecked = false;
    });
  }

  Future getUsers() async {
    var usersDb = await MongoDatabase.getUsersFromInfoUsers();
    setState(() {
      users = usersDb;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(pageTitle: 'Contacts'),
      body: ListView(
        children: [
          Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Email'),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Name'),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Last Name'),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _date,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.date_range),
                          border: OutlineInputBorder(),
                          hintText: 'Select date of birth'),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime(1950),
                            lastDate: DateTime.now());

                        if (pickedDate != null) {
                          setState(() {
                            _date.text =
                                DateFormat('dd-MM-yyyy').format(pickedDate);
                          });
                        }
                      },
                    ),
                    Row(
                      children: [
                        Radio(
                          value: "male",
                          groupValue: sex,
                          onChanged: (value) {
                            setState(() {
                              sex = value!;
                            });
                          },
                        ),
                        Text('male'),
                        Radio(
                          value: "female",
                          groupValue: sex,
                          onChanged: (value) {
                            setState(() {
                              sex = value!;
                            });
                          },
                        ),
                        Text('female'),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value!;
                              });
                            }),
                        Text('Сonfirm'),
                      ],
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              final email = _emailController.text;
                              final name = _firstNameController.text;
                              final lastName = _lastNameController.text;
                              final date = _date.text;

                              UserInfo userInfo = UserInfo(
                                  email: email,
                                  firstName: name,
                                  lastName: lastName,
                                  date: date,
                                  sex: sex,
                                  confirm: isChecked);
                              var result = await MongoDatabase.insertUser(
                                  userInfo.toJson());
                              if (result == null) {
                                print('error');
                              } else {
                                resetFields();
                              }
                            },
                            child: Text('Create')),
                        SizedBox(
                          width: 16,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              final email = _emailController.text;
                              final name = _firstNameController.text;
                              final lastName = _lastNameController.text;
                              final date = _date.text;

                              UserInfo userInfo = UserInfo(
                                  email: email,
                                  firstName: name,
                                  lastName: lastName,
                                  date: date,
                                  sex: sex,
                                  confirm: isChecked);
                              await MongoDatabase.updateUser(
                                  email, userInfo.toJson());
                              resetFields();
                            },
                            child: Text('Update')),
                        SizedBox(
                          width: 16,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              final email = _emailController.text;
                              await MongoDatabase.deleteUser(email);
                              resetFields();
                            },
                            child: Text('Delete')),
                      ],
                    ),
                  ],
                ),
              )),
          SizedBox(
            height: 20,
          ),
          ...users
              .map((item) => UsersListWidget(
                    emailUser: item['email'],
                    nameUser: item['firstName'],
                    lastNameUser: item['lastName'],
                    dateUser: item['date'],
                    sexUser: item['sex'],
                    confirmUser: item['confirm'],
                    emailController: _emailController,
                    firstNameController: _firstNameController,
                    lastNameController: _lastNameController,
                    dateController: _date,
                    sex: sex,
                    isChecked: isChecked,
                  ))
              .toList(),
        ],
      ),
    );
  }
}

class UsersListWidget extends StatefulWidget {
  String emailUser;
  String nameUser;
  String lastNameUser;
  String dateUser;
  String sexUser;
  bool confirmUser;
  TextEditingController emailController;
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController dateController;
  String sex;
  bool isChecked;

  UsersListWidget({
    super.key,
    required this.emailUser,
    required this.nameUser,
    required this.lastNameUser,
    required this.dateUser,
    required this.sexUser,
    required this.confirmUser,
    required this.emailController,
    required this.firstNameController,
    required this.lastNameController,
    required this.dateController,
    required this.sex,
    required this.isChecked,
  });

  @override
  State<UsersListWidget> createState() => _UsersListWidgetState();
}

class _UsersListWidgetState extends State<UsersListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        title: Stack(
          children: [
            Column(children: [
              Text(widget.emailUser),
              Text(widget.nameUser),
              Text(widget.lastNameUser),
              Text(widget.dateUser),
              Text(widget.sexUser),
              Text(widget.confirmUser ? 'confirm' : 'not confirmed'),
              Divider(),
            ]),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                widget.emailController.text = widget.emailUser;
                widget.firstNameController.text = widget.nameUser;
                widget.lastNameController.text = widget.lastNameUser;
                widget.dateController.text = widget.dateUser;
              },
            ),
          ],
        ),
      ),
    ]);
  }
}
