import 'package:get/get.dart';

class LoadingAnimationController extends GetxController{
  bool isDoneLoading  = false;
  @override
  void onInit() {
    isDoneLoading  = false;
    super.onInit();
  }
  changeStatus(){
    isDoneLoading  = !isDoneLoading;
    update();
  }
}