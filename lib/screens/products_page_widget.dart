import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/header.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ProductsPageWidget extends StatefulWidget {
  const ProductsPageWidget({super.key});

  @override
  State<ProductsPageWidget> createState() => _ProductsPageWidgetState();
}

class _ProductsPageWidgetState extends State<ProductsPageWidget> {
  String food = 'cheese';
  bool isChecked = false;

  List<String> listItem = ['Blue', 'Green', 'Brown'];
  String? eyesChoose;

  List<String> selectedInterests = [];
  List<String> interestsList = [
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
            Text('Choose your eyes color'),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration.collapsed(hintText: ''),
                value: eyesChoose,
                onChanged: (value) {
                  setState(() {
                    eyesChoose = value;
                  });
                },
                items: listItem.map((valueItem) {
                  return DropdownMenuItem<String>(
                      value: valueItem, child: Text(valueItem));
                }).toList(),
              ),
            ),
            MultiSelectDialogField<String>(
              chipDisplay: MultiSelectChipDisplay.none(),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              items: interestsList
                  .map(
                      (interest) => MultiSelectItem<String>(interest, interest))
                  .toList(),
              title: Text('Select Interests'),
              buttonText: Text('Select Interests'),
              onConfirm: (values) {
                setState(() {
                  selectedInterests = values;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
