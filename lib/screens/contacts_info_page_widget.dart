import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/modal_contacts_delete.dart';
import 'package:flutter_application_1/models/user_info.dart';
import 'package:flutter_application_1/components/header.dart';
import 'package:flutter_application_1/state/app_state.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../server/mongodb.dart';

class ContactsInfoPageWidget extends StatefulWidget {
  const ContactsInfoPageWidget({super.key});

  @override
  State<ContactsInfoPageWidget> createState() => _ContactsInfoPageWidgetState();
}

class _ContactsInfoPageWidgetState extends State<ContactsInfoPageWidget> {
  final userID = AppState.userID;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = true;
  bool _activatedEdit = false;
  List<UserInfo> users = [];
  String sex = 'male';
  bool isChecked = false;
  String? notUpdatedEmail;
  List<String> listEyesColor = ['Blue', 'Green', 'Brown'];
  String _eyesChoose = '';

  List _selectedInterests = [];

  final List<String> _interestsList = [
    'Reading',
    'Traveling',
    'Photography',
    'Cooking',
    'Gaming',
    'Sports',
    'Music',
    'Art',
    'Movies',
  ];

  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _date = TextEditingController();

  @override
  void initState() {
    getUsers(userID);
    _eyesChoose = listEyesColor.first;
    super.initState();
  }

  addUser(user) async {
    try {
      var result = await MongoDatabase.insertUser(user);
      if (result == null) return;
      if (result != false) {
        setState(() {
          users.add(UserInfo.fromMap(user));
        });
        resetFields();
        return true;
      }
      return false;
    } catch (e) {
      throw Exception('Error add user: $e');
    }
  }

  void updateUser(email, updatedUser) async {
    try {
      var result = await MongoDatabase.updateUser(email, updatedUser);
      if (result == null) return;
      resetFields();
      setState(() {
        int index = users.indexWhere((element) => element.email == email);
        if (index != -1) {
          users[index] = UserInfo.fromMap(updatedUser);
        }
        _activatedEdit = false;
      });
    } catch (e) {
      throw Exception('Error updating user: $e');
    }
  }

  Future<void> deleteUserByEmail(email) async {
    try {
      setState(() {
        _isLoading = true;
      });
      var result = await MongoDatabase.deleteUser(email);
      if (result == null) {
        setState(() {
          _isLoading = false;
        });
        return;
      }
      resetFields();
      setState(() {
        users.removeWhere((element) => element.email == email);
        _isLoading = false;
      });
    } catch (e) {
      throw Exception('Error updating user: $e');
    }
  }

  Future getUsers(userID) async {
    try {
      setState(() {
        _isLoading = true;
      });

      List<Map<String, Object?>> usersDb =
          await MongoDatabase.getUsersFromInfoUsers(userID);
      setState(() {
        users = usersDb.map((item) => UserInfo.fromMap(item)).toList();
        _isLoading = false;
      });
    } catch (e) {
      throw Exception('Error deleting user: $e');
    }
  }

  void resetFields() {
    _emailController.clear();
    _firstNameController.clear();
    _date.clear();
    setState(() {
      sex = 'male';
      isChecked = false;
      _eyesChoose = listEyesColor.first;
      _selectedInterests = [];
    });
  }

  void _showModal(BuildContext context, Function onYesPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ModalContactsDelete(
          onYesPressed: onYesPressed,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(pageTitle: 'Contacts info'),
      body: ListView(
        children: [
          Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        }

                        const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                        final regExp = RegExp(pattern);

                        if (!regExp.hasMatch(value)) {
                          return 'Please enter a valid email';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Name'),
                      validator: (value) {
                        if (value == null || value.length < 3) {
                          return 'Enter 3 or more letters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonFormField<String>(
                        decoration:
                            const InputDecoration.collapsed(hintText: ''),
                        value: _eyesChoose,
                        onChanged: (value) {
                          setState(() {
                            _eyesChoose = value as String;
                          });
                        },
                        items: listEyesColor.map((valueItem) {
                          return DropdownMenuItem<String>(
                              value: valueItem, child: Text(valueItem));
                        }).toList(),
                        hint: const Text('Choose your eyes color'),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    MultiSelectDialogField<String>(
                      initialValue: [..._selectedInterests],
                      chipDisplay: MultiSelectChipDisplay.none(),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      items: _interestsList
                          .map((interest) =>
                              MultiSelectItem<String>(interest, interest))
                          .toList(),
                      title: const Text('Select Interests'),
                      buttonText: const Text('Select Interests'),
                      onConfirm: (values) {
                        setState(() {
                          _selectedInterests = values;
                        });
                      },
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
                        SizedBox(
                          width: 130,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final email = _emailController.text;
                                  final name = _firstNameController.text;
                                  final date = _date.text;

                                  UserInfo userInfo = UserInfo(
                                      email: email,
                                      firstName: name,
                                      eyes: _eyesChoose,
                                      date: date,
                                      sex: sex,
                                      confirm: isChecked,
                                      interests: _selectedInterests,
                                      userID: userID);

                                  var result = await addUser(userInfo.toJson());
                                  if (result == null) return;
                                  if (result == false) {
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        backgroundColor: Colors.red[400],
                                        content: const Text(
                                            "User with that email already exists!"),
                                      ));
                                    }
                                  } else {
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        backgroundColor: Colors.green[400],
                                        content: const Text(
                                            "User successfully added!"),
                                      ));
                                    }
                                  }
                                }
                              },
                              child: const Text('Create')),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        if (_activatedEdit)
                          SizedBox(
                            width: 130,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    final email = _emailController.text;
                                    final name = _firstNameController.text;
                                    final date = _date.text;

                                    UserInfo userInfo = UserInfo(
                                        email: email,
                                        firstName: name,
                                        eyes: _eyesChoose,
                                        date: date,
                                        sex: sex,
                                        confirm: isChecked,
                                        interests: _selectedInterests,
                                        userID: userID);
                                    if (notUpdatedEmail != null) {
                                      updateUser(
                                          notUpdatedEmail, userInfo.toJson());
                                    }
                                  }
                                },
                                child: const Text('Update')),
                          ),
                      ],
                    ),
                  ],
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          _isLoading
              ? const SizedBox(
                  height: 100,
                  width: 100,
                  child: Center(child: CircularProgressIndicator()))
              : Column(
                  children: [
                    ...users.map((item) => Column(children: [
                          ListTile(
                            leading: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _emailController.text = item.email;
                                _firstNameController.text = item.firstName;
                                _date.text = item.date;
                                setState(() {
                                  _eyesChoose = item.eyes;
                                  notUpdatedEmail = item.email;
                                  sex = item.sex;
                                  isChecked = item.confirm;
                                  _activatedEdit = true;
                                  _selectedInterests = item.interests;
                                });
                              },
                            ),
                            title: Column(children: [
                              Text(item.email),
                              Text(item.firstName),
                              Text(item.eyes),
                              Text(item.interests.join(', ')),
                              Text(item.date),
                              Text(item.sex),
                              Text(item.confirm ? 'confirm' : 'not confirmed'),
                              const Divider(),
                            ]),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_forever),
                              onPressed: () async {
                                final email = item.email;
                                _showModal(
                                    context, () => deleteUserByEmail(email));
                              },
                            ),
                          ),
                        ])),
                  ],
                ),
        ],
      ),
    );
  }
}
