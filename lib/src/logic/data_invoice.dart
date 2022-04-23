import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataInvoice extends GetxController {
  TextEditingController? price;

  TextEditingController? whoIsPay;

  TextEditingController? whoIsTake;

  TextEditingController? priceWithText;

  TextEditingController? causeOfPayment;

  @override
  void onInit() {
    
        price = TextEditingController();
    whoIsPay = TextEditingController();
    whoIsTake = TextEditingController();
    priceWithText = TextEditingController();
    causeOfPayment = TextEditingController();
    super.onInit();
  }

  
  
  
  changeValueOfTabController(value) {
  
    update();
  }
  changeValueOfSelectedIndex(value) {

    update();
  }
}
