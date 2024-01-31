import 'package:MultiApp/utils/network_util.dart';
import 'package:flutter/material.dart';
import '../components/header.dart';
import '../models/user.dart';
import '../server/mongodb.dart';
import '../state/app_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
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

  Future<void> _showModal() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Warning'),
            content: const Text('No internet connection'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK')),
            ],
          );
        });
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
                            var isInternet = await NetworkUtil.hasConnection();
                            if (!isInternet) {
                              _showModal();
                              return;
                            }
                            try {
                              showCircular();
                              final user = await MongoDatabase.loginUser(
                                  email, password);
                              if (user != null) {
                                AppState.userID = user['_id'].toString();
                                AppState.userStore = User.fromMap(user);
                                if (context.mounted) {
                                  Navigator.pushNamed(context, 'user');
                                }
                                setState(() {
                                  _loginError = false;
                                });
                              } else {
                                setState(() {
                                  _loginError = true;
                                });
                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
                              }
                            } catch (e) {
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                              setState(() {
                                _loginError = true;
                              });
                              throw Exception('Login failed: $e');
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

  Future showCircular() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
