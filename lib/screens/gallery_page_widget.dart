import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/header.dart';

class GalleryPageWidget extends StatelessWidget {
  const GalleryPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(pageTitle: 'Gallery'),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Container(
                    color: Colors.red[400],
                  ),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
