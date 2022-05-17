import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:fatora/src/Constant/color_app.dart';
import 'package:fatora/src/views/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../../logic/data_for_catch.dart';

class SignaturePage extends StatefulWidget {
  const SignaturePage({Key? key}) : super(key: key);

  @override
  State<SignaturePage> createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  var signaturePadKey = GlobalKey<SfSignaturePadState>();

  @override
  Widget build(BuildContext context) {
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
              key: signaturePadKey,
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
    signaturePadKey.currentState!.clear();
  }

  saveButton() async {
    ui.Image image = await signaturePadKey.currentState!.toImage();
    final bytesData = await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List imageBytes = bytesData!.buffer
        .asUint8List(bytesData.offsetInBytes, bytesData.lengthInBytes);
    final String path = (await getApplicationDocumentsDirectory()).path;
    final String fileName = "$path/signature.png";
    Get.find<DataForCatch>().changeFileNameSignature(fileName);
    final File file = File(fileName);
    await file.writeAsBytes(imageBytes, flush: true);
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const HomePage()));
  }
}
