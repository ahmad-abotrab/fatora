import 'dart:io';

import 'package:fatora/receipts_db.dart';
import 'package:fatora/src/constant/color_app.dart';
import 'package:fatora/src/data/repository/receipt_repository.dart';
import 'package:fatora/src/data/web_services/pdf_opened.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../components/empty_widget_response.dart';

// ignore: must_be_immutable
class ListReceiptNotSentByWhatsUp extends StatelessWidget {
  ListReceiptNotSentByWhatsUp({Key? key}) : super(key: key);
  ReceiptsDB receiptsDB = ReceiptsDB();

  Future<List<Map<dynamic, dynamic>>> getReceiptNotSend() async {
    List<Map<dynamic, dynamic>> receipts = [];

    String sql = '''
        SELECT r.whoIsTake, t.pathDB, r.idLocal , r.receiptPdfFileName
        FROM receipts r
        INNER JOIN receiptStatus t
        ON r.idLocal = t.idLocal
        WHERE t.statusSend_WhatsApp = 0
    ''';
    try {
      receipts = await receiptsDB.readData(sql);
      return receipts;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorApp.primaryColor,
        title: const FittedBox(
          child: Text('الفواتير التي لم ترسل عبر الواتس'),
        ),
      ),
      body: RefreshIndicator(
        edgeOffset: 40,
        onRefresh: getReceiptNotSend,
        child: SingleChildScrollView(
          child: FutureBuilder<List<Map<dynamic, dynamic>>>(
            future: getReceiptNotSend(),
            builder:
                (context, AsyncSnapshot<List<Map<dynamic, dynamic>>> snapShot) {
              if (snapShot.hasData) {
                if (snapShot.data!.isEmpty) {
                  return const EmptyWidgetResponse(
                      title: 'تحذير', content: 'لا يوجد بيانات');
                } else {
                  return ListView.separated(
                    physics: const ScrollPhysics(),
                    itemCount: snapShot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: IconButton(
                          onPressed: () {
                            var id = snapShot.data![index]['idLocal'];
                            File file = File(snapShot.data![index]['pathDB']);
                            // PDFOpened.openFile(file);
                            sendReceiptPdfByWhatsApp(file, id, context);
                          },
                          icon: const Icon(Icons.send),
                        ),
                        title: Text(snapShot.data![index]['whoIsTake']),
                        trailing: IconButton(
                          onPressed: () async {
                            bool fileIsExists =
                                await File(snapShot.data![index]['pathDB'])
                                    .exists();
                            if (fileIsExists) {
                              await PDFOpened.openFile(
                                  File(snapShot.data![index]['pathDB']));
                            } else {
                              File file = await ReceiptRepository()
                                  .downloadReceipt(snapShot.data![index]
                                      ['receiptPdfFileName']);
                              await PDFOpened.openFile(file);
                            }
                          },
                          icon: const FaIcon(FontAwesomeIcons.filePdf,
                              color: Colors.red),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        color: Colors.black,
                      );
                    },
                  );
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  sendReceiptPdfByWhatsApp(file, id, context) async {
    bool shared = false;
    try {
      await Share.shareFiles([file.path], text: "هـذا إيصال الدفع الخاص بك");
      shared = true;
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Text('يوجد خطأ'),
            content: const Text(' لايمكن فتح الواتس اب لان '),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('رجوع'))
            ],
          );
        },
      );
    }
    if (shared) {
      String sql = '''
                  UPDATE receiptStatus
                  SET statusSend_WhatsApp = ?
                  WHERE idLocal = ?;
                  ''';
      List data = [1, id];
      await receiptsDB.updateData(sql, data);
    } else {
      String sql = '''
                  UPDATE receiptStatus
                  SET statusSend_WhatsApp = ?
                  WHERE idLocal = ?;
                  ''';
      List data = [0, id];
      await receiptsDB.updateData(sql, data);
    }
  }
}
