import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:fatora/src/views/components/empty_widget_response.dart';
import 'package:flutter/material.dart';

class PdfViewerLocal extends StatefulWidget {
  PdfViewerLocal({Key? key, required this.fileName}) : super(key: key);
  String? fileName;

  @override
  State<PdfViewerLocal> createState() => _PdfViewerLocalState();
}

class _PdfViewerLocalState extends State<PdfViewerLocal> {
  PDFDocument? document;

  _future() async {
    var url = 'http://77.44.176.222:8080/storage/app/public/receipt/temp/' +
        widget.fileName!;
    document = await PDFDocument.fromURL(url);
  }

  @override
  void initState() {
    super.initState();
    _future();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: _future(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Center(child: PDFViewer(document: document!));
                } else {
                  return const EmptyWidgetResponse(
                      title: 'تحذير', content: 'لم يتم تحميل الملف');
                }
              }
            }
            return const EmptyWidgetResponse(
                title: 'title', content: 'لايوجد ملف');
          },
        ),
      ),
    );
  }
}
