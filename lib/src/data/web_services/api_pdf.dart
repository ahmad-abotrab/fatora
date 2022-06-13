import 'dart:io';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '/src/data/web_services/pdf_opened.dart';
import '../model/receipt_model.dart';

class ApiPdf {
  static TextDirection textDirection = TextDirection.rtl;

  static Future<File> generate(String fileName, Receipt data, imageSignature,
      id, String dataTime, type) async {
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
        buildHeader(id, data.amountNumeric, type),
        SizedBox(height: 1 * PdfPageFormat.cm),

        /*   data[0] who is take money
         **  data[2] amount text
         **  data[3] cause of payment
        */
        buildBody(data.whoIsTake, data.amountText, data.causeOfPayment),
        SizedBox(height: 1 * PdfPageFormat.cm),
        Divider(),
        buildFooter(dataTime, signature: imageSignature),
      ],
      // footer: (context) => buildFooter(),
    ));

    return PDFOpened.saveDocument(name: fileName, pdf: pdf);
  }

  static buildHeader(id, price, type) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Directionality(
                textDirection: textDirection,
                child: Text(
                  type == 0 ? 'وصل دفع' : 'وصل قبض',
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
                  'رقم   ' "$id",
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

  static buildFooter(dateTime, {signature}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Directionality(
                textDirection: textDirection,
                child: Text(
                  'التاريخ',
                  style: const TextStyle(fontSize: 25),
                ),
              ),
              SizedBox(height: 0.5 * PdfPageFormat.cm),
              Text(
                dateTime,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Directionality(
                textDirection: textDirection,
                child: Text(
                  'التوقيع',
                  style: const TextStyle(fontSize: 25),
                ),
              ),
              SizedBox(height: 0.5 * PdfPageFormat.cm),
              Container(
                child: Image(
                  MemoryImage(signature),
                  width: 6 * PdfPageFormat.cm,
                  height: 6 * PdfPageFormat.cm,
                ),
              )
            ],
          ),
        ],
      );


  static buildText({
    required String staticText,
    required String dynamicText,
    secondaryStaticText,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          secondaryStaticText != null
              ? Directionality(
                  textDirection: textDirection,
                  child: Text(
                    secondaryStaticText,
                    style:  const TextStyle(
                      fontSize: 25,
                      color: PdfColor.fromInt(0x000000),

                    ),
                  ),
                )
              : Directionality(
                  textDirection: textDirection,
                  child: Text(''),
                ),
          // SizedBox(width: 0.01 * PdfPageFormat.cm),
          Expanded(
            child: Directionality(
              textDirection: textDirection,
              child: Text(
                dynamicText,
                style: const TextStyle(
                    fontSize: 17,
                    color: PdfColor.fromInt(0x000000),
                    ),
              ),
            ),
          ),
          // SizedBox(width: 0.01 * PdfPageFormat.cm),
          Directionality(
            textDirection: textDirection,
            child: Text(
              staticText,
              style:  TextStyle(
                fontSize: 15,
                color: const PdfColor.fromInt(0x000000),
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      );

  /// build body
  static buildBody(
    whoIsTake,
    amountText,
    causeOfPayment,
  ) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        buildText(
          staticText: 'قبضت من السيد :',
          dynamicText: whoIsTake + ' المحترم.',
        ),
        SizedBox(height: 0.5 * PdfPageFormat.cm),
        buildText(
          staticText: 'مبلغاً وقدره:',
          dynamicText: ' فقط'+amountText.toString() + ' لاغير .',
        ),
        SizedBox(height: 0.5 * PdfPageFormat.cm),
        buildText(
          staticText: ' وذلك لقاء :',
          dynamicText:  '.'+ causeOfPayment ,
        ),
      ]);
}
