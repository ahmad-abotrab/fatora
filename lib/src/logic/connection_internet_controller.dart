import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectionInternetController extends GetxController{
  bool? hasInternet;
  ConnectivityResult? connectivityResult;

  @override
  void onInit() {
    hasInternet = false;
    connectivityResult = ConnectivityResult.none;
    super.onInit();
  }

  changeValues(bool internetStatus,ConnectivityResult valueConnectivityResult){
    hasInternet = internetStatus;
    connectivityResult = valueConnectivityResult;
    update();
  }
}