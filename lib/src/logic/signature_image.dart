import 'package:get/get.dart';

class SignaturePageController extends GetxController{
  String fileNameSignature = '';
  int selectedIndex = 0;
  @override
  void onInit() {
    selectedIndex = 0;
    fileNameSignature = '';
    super.onInit();
  }
  changedPathToSignature(value){
    fileNameSignature = value;
    update();
  }
  updateSelectedIndex(value){
    selectedIndex = value;
    update();
  }
  reinitialize(){
    fileNameSignature = '';
    update();
  }
}