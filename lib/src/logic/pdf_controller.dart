import 'package:get/get.dart';

class PdfController extends GetxController{
  int?  page;
  bool? isReady;
  @override
  void onInit() {
    page = 0;
    isReady = true;
    super.onInit();
  }
  changedValue(page,isReady){
    this.isReady = isReady;
    this.page = page;
    update();
  }
}