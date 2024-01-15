import 'package:flutter/material.dart';
import 'app.dart';
import 'server/mongodb.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const App());
}
