import 'package:flutter/material.dart';
import 'package:flutter_application_1/server/mongodb.dart';
import 'package:flutter_application_1/components/header.dart';

import '../models/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();
  final _userNameController = TextEditingController();

  bool _passwordError = false;
  bool _registerError = false;

  void resetFields() {
    _emailController.clear();
    _passwordController.clear();
    _repeatPasswordController.clear();
    _userNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)));

    return Scaffold(
      appBar: Header(pageTitle: 'Register'),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      child: TextFormField(
                        controller: _emailController,
                        decoration:
                            inputDecoration.copyWith(labelText: 'Email'),
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
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 300,
                      child: TextFormField(
                        controller: _userNameController,
                        decoration:
                            inputDecoration.copyWith(labelText: 'User name'),
                        validator: (value) {
                          if (value == null || value.length < 3) {
                            return 'Enter 3 or more letters';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 300,
                      child: TextFormField(
                        controller: _passwordController,
                        decoration:
                            inputDecoration.copyWith(labelText: 'Password'),
                        obscureText: true,
                        validator: (value) {
                          if ((value?.length ?? 0) < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 300,
                      child: TextFormField(
                        controller: _repeatPasswordController,
                        decoration: inputDecoration.copyWith(
                            labelText: 'Repeat Password'),
                        obscureText: true,
                        validator: (value) {
                          if ((value?.length ?? 0) < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                    ),
                    if (_registerError)
                      Container(
                        padding: const EdgeInsets.only(top: 16),
                        child: const Text(
                          'User with that email already exists',
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        ),
                      ),
                    if (_passwordError)
                      Container(
                        padding: const EdgeInsets.only(top: 16),
                        child: const Text(
                          'Invalid password',
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        ),
                      ),
                    const SizedBox(height: 16),
                    Container(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final email = _emailController.text;
                                final password = _passwordController.text;
                                final repeatPassword =
                                    _repeatPasswordController.text;
                                final userName = _userNameController.text;

                                if (password == repeatPassword) {
                                  User user = User(
                                      email: email,
                                      userName: userName,
                                      password: password,
                                      imageSrc: '');
                                  try {
                                    setState(() {
                                      _passwordError = false;
                                    });
                                    var result =
                                        await MongoDatabase.registerUser(
                                            user.toJson());
                                    if (result != null) {
                                      Navigator.pushNamed(context, 'login');
                                      resetFields();
                                      setState(() {
                                        _registerError = false;
                                      });
                                    } else {
                                      setState(() {
                                        _registerError = true;
                                      });
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                } else {
                                  setState(() {
                                    _passwordError = true;
                                  });
                                }
                              }
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(fontSize: 20),
                            ))),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
