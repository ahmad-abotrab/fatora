import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataForPayment extends GetxController {
  int selectedTabIndex = 0;
  TextEditingController? price;
  TextEditingController? amountText;
  TextEditingController? whoIsTake;
  TextEditingController? priceWithText;
  TextEditingController? causeOfPayment;

  @override
  void onInit() {
    price = TextEditingController();
    amountText = TextEditingController();
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

  changeSelectedTab(value) {
    selectedTabIndex = value;
    update();
  }


  reinitialize() {
    price = TextEditingController();
    amountText = TextEditingController();
    whoIsTake = TextEditingController();
    priceWithText = TextEditingController();
    causeOfPayment = TextEditingController();
    update();
  }
}
