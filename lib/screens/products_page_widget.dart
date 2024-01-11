import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/header.dart';

class ProductsPageWidget extends StatefulWidget {
  const ProductsPageWidget({super.key});

  @override
  State<ProductsPageWidget> createState() => _ProductsPageWidgetState();
}

class _ProductsPageWidgetState extends State<ProductsPageWidget> {
  String food = 'cheese';
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(pageTitle: 'Products'),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose something',
              style: TextStyle(fontSize: 20),
            ),
            ListTile(
              leading: Radio(
                  value: 'cheese',
                  groupValue: food,
                  onChanged: (value) {
                    setState(() {
                      food = value!;
                    });
                  }),
              title: Text('Cheese'),
            ),
            ListTile(
              leading: Radio(
                  value: 'apple',
                  groupValue: food,
                  onChanged: (value) {
                    setState(() {
                      food = value!;
                    });
                  }),
              title: Text('Apple'),
            ),
            ListTile(
              leading: Radio(
                  value: 'pork',
                  groupValue: food,
                  onChanged: (value) {
                    setState(() {
                      food = value!;
                    });
                  }),
              title: Text('Pork'),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Text('Сonfirm data'),
                Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
