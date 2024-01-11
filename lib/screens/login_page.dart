import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/config/users.dart';
import 'package:flutter_application_1/screens/header.dart';

class LoginPage extends StatefulWidget {
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
    _emailController.text = '111@m.ru';
    _passwordController.text = '123456';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: Header(pageTitle: 'Login'),
      body: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16))),
                    validator: (value) {
                      if (!(value?.contains('@') ?? false)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16),
                Container(
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
                SizedBox(height: 16),
                Container(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          final form = _formKey.currentState!;
                          final email = _emailController.text;
                          final password = _passwordController.text;
                          if (form.validate()) {
                            try {
                              final user = Config.users.firstWhere(
                                (user) =>
                                    user.email == email &&
                                    user.password == password,
                              );

                              Navigator.pushNamed(context, 'user',
                                  arguments: user);
                            } catch (e) {
                              setState(() {
                                _loginError = true;
                              });
                            }
                          } else {
                            print('Validation failed');
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue)),
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ))),
                if (_loginError)
                  Container(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
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
