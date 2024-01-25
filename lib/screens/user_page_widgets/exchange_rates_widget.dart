import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/currency.dart';
import 'package:flutter_application_1/server/api_currency_service.dart';
import 'package:intl/intl.dart';

class ExchangeRatesWidget extends StatefulWidget {
  const ExchangeRatesWidget({super.key});

  @override
  State<ExchangeRatesWidget> createState() => _ExchangeRatesWidgetState();
}

class _ExchangeRatesWidgetState extends State<ExchangeRatesWidget> {
  final TextEditingController _date = TextEditingController();

  @override
  void initState() {
    _date.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        TextFormField(
          controller: _date,
          decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.date_range),
              border: OutlineInputBorder(),
              hintText: 'Select date'),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime.now());

            if (pickedDate != null) {
              setState(() {
                _date.text = DateFormat('yyyy-MM-dd').format(pickedDate);
              });
            }
          },
        ),
        const SizedBox(height: 20),
        Expanded(
          child: FutureBuilder(
              future: getListOfRates(_date.text),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepPurpleAccent,
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'An ${snapshot.error} occurred',
                        style: const TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final List<CurrencyRate> data = snapshot.data;
                    if (data.isEmpty) {
                      return const Center(
                        child: Text('no internet connection'),
                      );
                    } else {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              String scale = '';
                              if (data[index].curScale != 1) {
                                scale = ' ${data[index].curScale}';
                              }
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text(
                                                data[index].curAbbreviation,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                scale,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              data[index].curRate.toString(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                ],
                              );
                            }),
                      );
                    }
                  }
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        )
      ]),
    );
  }

  Future getListOfRates(value) async {
    try {
      List<CurrencyRate> listAllCurrency = [];
      List<String> listRequiredCurrency = ['USD', 'EUR', 'RUB', 'UAH', 'PLN'];
      var data = await ApiCurrencyService.getCurrencyRates(value);
      if (data == null) {
        return <CurrencyRate>[];
      }
      for (var item in data) {
        listAllCurrency.add(CurrencyRate.fromMap(item));
      }
      List<CurrencyRate> newList = listAllCurrency
          .where((item) => listRequiredCurrency.contains(item.curAbbreviation))
          .toList();
      return newList;
    } catch (e) {
      throw Exception('Get currency failed: $e');
    }
  }
}
