import 'dart:io';
import 'package:fatora/src/data/server/pdf_opened.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class ApiPdf {
  static TextDirection textDirection = TextDirection.rtl;

  static Future<File> generate(
      String fileName, List<String> data, imageSignature, id) async {
    var arabicFontRegular = Font.ttf(
        await rootBundle.load("assets/fonts/Tajawal/Tajawal-Regular.ttf"));
    var arabicFontBold = Font.ttf(
        await rootBundle.load("assets/fonts/Tajawal/Tajawal-Bold.ttf"));
    final pdf = Document();
    pdf.addPage(MultiPage(
      theme: ThemeData.withFont(
        base: arabicFontRegular,
        bold: arabicFontBold,
      ),
      pageFormat: PdfPageFormat.a4,
      build: (context) => [
        SizedBox(height: 1 * PdfPageFormat.cm),
        buildHeader(id, data[2]),
        SizedBox(height: 2 * PdfPageFormat.cm),
        Divider(),
      ],
      // footer: (context) => buildFooter(),
    ));

    return PDFOpened.saveDocument(name: fileName, pdf: pdf);
  }

  static buildHeader(id, price) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Directionality(
                textDirection: textDirection,
                child: Text(
                  'وصل قبض',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: const PdfColor.fromInt(0xFF326197),
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.5 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Directionality(
                textDirection: textDirection,
                child: Text(
                  price + "    " + ' ل.س',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Directionality(
                textDirection: textDirection,
                child: Text(
                  'رقم   '  "$id",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: const PdfColor.fromInt(0xFFe63946),
                  ),
                ),
              ),
            ],
          ),
        ],
      );

  static buildFooter() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [],
      );


  static buildText({
    required String title,
    required String value,
  }) {}
}
