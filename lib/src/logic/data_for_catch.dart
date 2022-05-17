import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataForCatch extends GetxController {
  int selectedTabIndex = 0;
  TextEditingController? price;

  TextEditingController? amountText;

  TextEditingController? whoIsTake;

  TextEditingController? priceWithText;

  TextEditingController? causeOfPayment;
  String fileNameSignature = '';

  @override
  void onInit() {
    price = TextEditingController();
    amountText = TextEditingController();
    whoIsTake = TextEditingController();
    priceWithText = TextEditingController();
    causeOfPayment = TextEditingController();
    selectedTabIndex = 0;
    fileNameSignature = '';
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

  changeFileNameSignature(value) {
    fileNameSignature = value;
    update();
  }

  reinitialize() {
    price = TextEditingController();
    amountText = TextEditingController();
    whoIsTake = TextEditingController();
    priceWithText = TextEditingController();
    causeOfPayment = TextEditingController();
    fileNameSignature = '';
    update();
  }
}
