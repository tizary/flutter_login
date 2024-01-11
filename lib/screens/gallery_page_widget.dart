import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/header.dart';

class GalleryPageWidget extends StatelessWidget {
  const GalleryPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(pageTitle: 'Gallery'),
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(children: [
            Text('data'),
            Text('data'),
            Text('data'),
            Text('data'),
            Text('data'),
            Text('data'),
            Text('data'),
            Text('data'),
          ]),
          Column(children: [
            ListTile(
              title: Column(children: [
                Text('1'),
                Text('2'),
                Text('3'),
                Text('4'),
              ]),
            ),
            ListTile(
              title: Column(children: [
                Text('1'),
                Text('2'),
                Text('3'),
                Text('4'),
              ]),
            ),
            ListTile(
              title: Column(children: [
                Text('1'),
                Text('2'),
                Text('3'),
                Text('4'),
              ]),
            ),
            ListTile(
              title: Column(children: [
                Text('1'),
                Text('2'),
                Text('3'),
                Text('4'),
              ]),
            ),
            ListTile(
              title: Column(children: [
                Text('1'),
                Text('2'),
                Text('3'),
                Text('4'),
              ]),
            ),
            ListTile(
              title: Column(children: [
                Text('1'),
                Text('2'),
                Text('3'),
                Text('4'),
              ]),
            ),
          ]),
        ],
      ),
    );
  }
}
