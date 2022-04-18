import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityUtilities {

  static Future<bool?> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print('I am result: $connectivityResult');
    if (connectivityResult == ConnectivityResult.mobile) {
      print('I am connected to a mobile network.');
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print('I am connected to a wifi network.');
      return true;
    } else if (connectivityResult == ConnectivityResult.none) {
      print('I am not connected');
      return false;
    }

    return false;
  }

}