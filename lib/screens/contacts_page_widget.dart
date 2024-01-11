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
  final TextEditingController _date = TextEditingController();

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  void addUser(user) {
    setState(() {
      users.add(user);
    });
  }

  void updateUser(updatedUser) {
    setState(() {
      int index = users
          .indexWhere((element) => element['email'] == updatedUser['email']);
      users[index] = updatedUser;
    });
  }

  void deleteUserByEmail(email) {
    setState(() {
      users.removeWhere((element) => element['email'] == email);
    });
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
              padding: const EdgeInsets.all(20),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Email'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Name'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Last Name'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _date,
                      decoration: const InputDecoration(
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
                        const Text('male'),
                        Radio(
                          value: "female",
                          groupValue: sex,
                          onChanged: (value) {
                            setState(() {
                              sex = value!;
                            });
                          },
                        ),
                        const Text('female'),
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
                        const Text('Сonfirm'),
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
                                addUser(userInfo.toJson());
                                print(userInfo.toJson());
                                print(users);
                                resetFields();
                              }
                            },
                            child: const Text('Create')),
                        const SizedBox(
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

                              updateUser(userInfo.toJson());
                              resetFields();
                            },
                            child: const Text('Update')),
                      ],
                    ),
                  ],
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          ...users.map((item) {
            return Column(children: [
              ListTile(
                leading: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _emailController.text = item['email'];
                    _firstNameController.text = item['firstName'];
                    _lastNameController.text = item['lastName'];
                    _date.text = item['date'];
                    setState(() {
                      sex = item['sex'];
                      isChecked = item['confirm'];
                    });
                  },
                ),
                title: Column(children: [
                  Text(item['email']),
                  Text(item['firstName']),
                  Text(item['lastName']),
                  Text(item['date']),
                  Text(item['sex']),
                  Text(item['confirm'] ? 'confirm' : 'not confirmed'),
                  const Divider(),
                ]),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_forever),
                  onPressed: () async {
                    final email = _emailController.text;
                    await MongoDatabase.deleteUser(email);
                    deleteUserByEmail(email);
                    resetFields();
                  },
                ),
              ),
            ]);
          })
        ],
      ),
    );
  }
}