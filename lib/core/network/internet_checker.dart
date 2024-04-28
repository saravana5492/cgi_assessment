import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetChecker {
  static Future<bool> isInternetConnected() async {
    return await InternetConnectionChecker().hasConnection;
  }
}
