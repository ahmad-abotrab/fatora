import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class SignaturePageController extends GetxController {
  String pathSignatureCompany = '';
  int selectedIndex = 0;
  ByteData? bytesImage;

  var signaturePadKey = GlobalKey<SfSignaturePadState>();

  @override
  void onInit() {
    selectedIndex = 0;
    pathSignatureCompany = '';
    signaturePadKey = GlobalKey<SfSignaturePadState>();
    super.onInit();
  }


  changedPathToSignature(value) {
    pathSignatureCompany = value;
    signaturePadKey.currentState!.clear();
    update();
  }



  updateSelectedIndex(value) {
    selectedIndex = value;
    update();
  }

  changeFileForSignature(bytes) {

    bytesImage = bytes;
    update();
  }

  changePathSignatureCompany(value){
    pathSignatureCompany = value;
    update();
  }

  reinitialize() {
    bytesImage = null;
    update();
  }
}
