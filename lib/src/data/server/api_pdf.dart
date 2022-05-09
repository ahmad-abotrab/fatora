import 'dart:io';

import 'package:fatora/src/data/server/pdf_opened.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class ApiPdf{
  static Future<File> generate() async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(),
        SizedBox(height: 3 * PdfPageFormat.cm),
        Divider(),

      ],
      footer: (context) => buildFooter(),
    ));

    return PDFOpened.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static  buildHeader() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [])
    ],
  );



  static  buildTotal() {
    return null;
  }

  static  buildFooter() => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [

    ],
  );

  static buildSimpleText({
    required String title,
    required String value,
  }) {



  }

  static buildText({
    required String title,
    required String value,

  }) {
  }
}