import 'package:flutter/material.dart';
import 'package:flutter_application_1/server/mongodb.dart';
import 'package:flutter_application_1/components/header.dart';
import 'package:flutter_application_1/state/app_state.dart';

import '../models/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loginError = false;

  @override
  void initState() {
    _emailController.text = 'tor@test.com';
    _passwordController.text = '123456';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const Header(pageTitle: 'Login'),
      body: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16))),
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
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16))),
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
                SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () async {
                          final form = _formKey.currentState!;
                          final email = _emailController.text;
                          final password = _passwordController.text;
                          if (form.validate()) {
                            try {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              );

                              final user = await MongoDatabase.loginUser(
                                  email, password);
                              AppState.userID = user['_id'].toString();
                              AppState.userStore = User.fromMap(user);
                              Navigator.pushNamed(context, 'user');
                              setState(() {
                                _loginError = false;
                              });
                            } catch (e) {
                              Navigator.pop(context);
                              print(e);
                              setState(() {
                                _loginError = true;
                              });
                            }
                          }
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 20),
                        ))),
                if (_loginError)
                  Container(
                    padding: const EdgeInsets.only(top: 16),
                    child: const Text(
                      'Invalid email or password',
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  ),
              ],
            ),
          )),
    );
  }
}
