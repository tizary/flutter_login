import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/app_routes.dart';
import 'package:flutter_application_1/screens/address_page_widget.dart';
import 'package:flutter_application_1/screens/contacts_info_page_widget.dart';
import 'package:flutter_application_1/screens/gallery_page_widget.dart';
import 'package:flutter_application_1/screens/home_page.dart';
import 'package:flutter_application_1/screens/login_page.dart';
import 'package:flutter_application_1/screens/users_list_page_widget.dart';
import 'package:flutter_application_1/screens/phone_contacts_page_widget.dart';
import 'package:flutter_application_1/screens/register_page.dart';
import 'package:flutter_application_1/screens/user_page.dart';

import 'screens/user_page_widgets/user_location_page_widget.dart';
import 'screens/user_page_widgets/user_profile_page_widget.dart';
import 'screens/user_page_widgets/user_wallet_page_widget.dart';
import 'package:connection_notifier/connection_notifier.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return ConnectionNotifier(
      connectionNotificationOptions: const ConnectionNotificationOptions(
        disconnectedText: 'No internet',
      ),
      child: MaterialApp(
          title: 'My App',
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
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
            AppRoutes.login: (context) => const LoginPage(),
            AppRoutes.register: (context) => const RegisterPage(),
            AppRoutes.user: (context) => const UserPage(),
            AppRoutes.usersListPage: (context) => const UsersListPageWidget(),
            AppRoutes.contactsInfoPage: (context) =>
                const ContactsInfoPageWidget(),
            AppRoutes.phoneContactsPage: (context) =>
                const PhoneContactsPageWidget(),
            AppRoutes.galleryPage: (context) => const GalleryPageWidget(),
            AppRoutes.addressPage: (context) => const AddressPageWidget(),
            AppRoutes.userProfilePage: (context) =>
                const UserProfilePageWidget(),
            AppRoutes.userWalletPage: (context) => const UserWalletPageWidget(),
            AppRoutes.userLocationPage: (context) =>
                const UserLocationPageWidget(),
          }),
    );
  }
}
