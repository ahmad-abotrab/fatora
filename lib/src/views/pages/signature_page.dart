import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '/src/Constant/color_app.dart';
import '../../logic/signature_image.dart';

class SignaturePage extends StatefulWidget {
  const SignaturePage({Key? key}) : super(key: key);

  @override
  State<SignaturePage> createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  var s = Get.put(SignaturePageController());

  @override
  Widget build(BuildContext context) {
    // var sign = Get.lazyPut(() => SignaturePageController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorApp.primaryColor,
        title: const Directionality(
          textDirection: TextDirection.rtl,
          child: Text('إضافة توقيع'),
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SfSignaturePad(
              key: s.signaturePadKey,
              backgroundColor: Colors.white,
              strokeColor: Colors.blue,
              minimumStrokeWidth: 4.0,
              maximumStrokeWidth: 6.0,
            ),
          ),
          const Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox(
                width: 20,
              )),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: ColorApp.primaryColor,
              ),
              child: TextButton(
                onPressed: saveButton,
                child: const Text(
                  'save Image',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          const Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                width: 20,
              )),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: ColorApp.primaryColor,
              ),
              child: TextButton(
                onPressed: clearButton,
                child: const Text(
                  'clear',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      // resizeToAvoidBottomInset: false,
    );
  }

  clearButton() {
    s.signaturePadKey.currentState!.clear();
  }

  saveButton() async {
    ui.Image image = await s.signaturePadKey.currentState!.toImage();
    final bytesData = await image.toByteData(format: ui.ImageByteFormat.png);
    s.changeFileForSignature(bytesData);
    Navigator.pop(context);
  }
}
