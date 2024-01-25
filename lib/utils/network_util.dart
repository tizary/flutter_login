import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkUtil {
  static Future<bool> hasConnection() async {
    var connectivity = Connectivity();
    var result = await connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }
}