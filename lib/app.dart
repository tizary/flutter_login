import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_routes.dart';
import 'screens/address_page_widget.dart';
import 'screens/contacts_info_page_widget.dart';
import 'screens/gallery_page_widget.dart';
import 'screens/home_page.dart';
import 'screens/login_page.dart';
import 'screens/phone_contacts_page_widget.dart';
import 'screens/register_page.dart';
import 'screens/user_page.dart';
import 'screens/user_page_widgets/user_location_page_widget.dart';
import 'screens/user_page_widgets/user_profile_page_widget.dart';
import 'screens/user_page_widgets/user_wallet_page_widget.dart';
import 'screens/users_list_page_widget.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    _checkInternet();
  }

  void _checkInternet() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _showWarning();
    }
  }

  void _showWarning() {
    scaffoldMessengerKey.currentState?.showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          "No Internet Connection!",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        scaffoldMessengerKey: scaffoldMessengerKey,
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
          AppRoutes.userProfilePage: (context) => const UserProfilePageWidget(),
          AppRoutes.userWalletPage: (context) => const UserWalletPageWidget(),
          AppRoutes.userLocationPage: (context) =>
              const UserLocationPageWidget(),
        });
  }
}
