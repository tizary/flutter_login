import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/burger_menu.dart';
import 'package:flutter_application_1/screens/header.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool _loading = false;
  double _progressValue = 0.0;
  int _count = 51;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(pageTitle: 'User'),
        backgroundColor: const Color.fromARGB(255, 99, 149, 229),
        drawer: BurgerMenu(),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/bg.jpg'),
              fit: BoxFit.cover,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ProgressDownloadWidget(loading: _loading, progressValue: _progressValue),
                Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        Text(
                          'Tap "-" to decrement',
                          style: TextStyle(color: Colors.white),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _count -= 1;
                                });
                              },
                              icon: Icon(Icons.remove),
                              color: Colors.white,
                            ),
                            Text('$_count',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24)),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _count += 1;
                                });
                              },
                              icon: Icon(Icons.add),
                              color: Colors.white,
                            ),
                          ],
                        ),
                        Text(
                          'Tap "+" to increment',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )),
              ],
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _loading = !_loading;
              _updateProgress();
            });
          },
          child: Icon(Icons.cloud_download),
        ));
  }

  void _updateProgress() {
    const oneSec = const Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer t) {
      setState(() {
        _progressValue += 0.2;

        if (_progressValue.toStringAsFixed(1) == '1.0') {
          _loading = false;
          t.cancel();
          _progressValue = 0.0;
          return;
        }
      });
    });
  }
}

class _ProgressDownloadWidget extends StatelessWidget {
  const _ProgressDownloadWidget({
    super.key,
    required bool loading,
    required double progressValue,
  }) : _loading = loading, _progressValue = progressValue;

  final bool _loading;
  final double _progressValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: _loading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  LinearProgressIndicator(
                    value: _progressValue,
                    backgroundColor: Colors.orange,
                    color: Colors.yellow,
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${(_progressValue * 100).round()}%',
                    style: TextStyle(
                        fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                ])
          : Text('Press button to download',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold)),
    );
  }
}
