import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataForCatch extends GetxController {
  int selectedTabIndex = 0;
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
    selectedTabIndex = 0;
    super.onInit();
  }

  changeValueOfTabController(value) {
    update();
  }

  changeValueOfSelectedIndex(value) {
    update();
  }
  changeSelectedTab(value){
    selectedTabIndex = value;
    update();
  }

  reinitialize() {
    price = TextEditingController();
    whoIsPay = TextEditingController();
    whoIsTake = TextEditingController();
    priceWithText = TextEditingController();
    causeOfPayment = TextEditingController();
    update();
  }
}
