import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormValidationController extends GetxController{
  late  var formStateCatch = GlobalKey<FormState>();
  late  var  formStatePayment = GlobalKey<FormState>();
  @override
  void onInit() {
    formStateCatch = GlobalKey<FormState>();
    formStatePayment = GlobalKey<FormState>();
    super.onInit();
  }

}