import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/address_page_widget.dart';
import 'package:flutter_application_1/screens/contacts_page_widget.dart';
import 'package:flutter_application_1/screens/gallery_page_widget.dart';
import 'package:flutter_application_1/screens/home_page.dart';
import 'package:flutter_application_1/screens/login_page.dart';
import 'package:flutter_application_1/screens/main_page_widget.dart';
import 'package:flutter_application_1/screens/products_page_widget.dart';
import 'package:flutter_application_1/screens/register_page.dart';
import 'package:flutter_application_1/screens/user_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My App',
        home: HomePage(),
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
          ),
          buttonTheme: const ButtonThemeData(buttonColor: Colors.blue),
          elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.blue),
              foregroundColor: MaterialStatePropertyAll(Colors.white),
            ),
          ),
        ),
        routes: {
          'login': (context) => const LoginPage(),
          'register': (context) => const RegisterPage(),
          'user': (context) => UserPage(),
          'main_page': (context) => const MainPageWidget(),
          'contacts_page': (context) => const ContactsPageWidget(),
          'products_page': (context) => const ProductsPageWidget(),
          'gallery_page': (context) => const GalleryPageWidget(),
          'address_page': (context) => const AddressPageWidget(),
        });
  }
}
