import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const Header(pageTitle: 'My App'),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Authorization', style: TextStyle(fontSize: 28)),
              const SizedBox(height: 36),
              SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'login');
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 20),
                    )),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'register');
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 20),
                    )),
              ),
            ],
          ),
        ));
  }
}
