import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:fatora/src/Constant/color_app.dart';
import 'package:fatora/src/Constant/path_images.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class SignaturePage extends StatefulWidget {
  const SignaturePage({Key? key}) : super(key: key);

  @override
  State<SignaturePage> createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  GlobalKey<SfSignaturePadState> signaturePadKey = GlobalKey();

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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.99,
              child: SfSignaturePad(
                key: signaturePadKey,
                backgroundColor: Colors.grey,
                strokeColor: Colors.white,
                minimumStrokeWidth: 4.0,
                maximumStrokeWidth: 6.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: ColorApp.primaryColor,
                  ),
                  child: ElevatedButton(
                      onPressed: clearButton, child: const Text('clear')),
                ),
                Expanded(
                  child: Container(),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: ColorApp.primaryColor,
                  ),
                  child: ElevatedButton(
                      onPressed: saveButton, child: const Text('save Image')),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
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
    fileNameSignature = fileName;
    final File file = File(fileName);
    await file.writeAsBytes(imageBytes, flush: true);
  }
}
