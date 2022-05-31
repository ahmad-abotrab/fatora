import 'dart:io';

import 'package:fatora/receipts_db.dart';
import 'package:fatora/src/constant/color_app.dart';
import 'package:fatora/src/data/repository/receipt_repository.dart';
import 'package:fatora/src/data/web_services/pdf_opened.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../logic/receipts_not_send_by_whats.dart';
import '../components/empty_widget_response.dart';

// ignore: must_be_immutable
class ListReceiptNotSentByWhatsUp extends StatefulWidget {
  const ListReceiptNotSentByWhatsUp({Key? key}) : super(key: key);

  @override
  State<ListReceiptNotSentByWhatsUp> createState() =>
      _ListReceiptNotSentByWhatsUpState();
}

class _ListReceiptNotSentByWhatsUpState
    extends State<ListReceiptNotSentByWhatsUp> {
  ReceiptsDB receiptsDB = ReceiptsDB();

  Future<List<Map<dynamic, dynamic>>> _getReceiptNotSend() async {
    String sql = '''
        SELECT r.whoIsTake, t.pathDB, r.idLocal , r.receiptPdfFileName
        FROM receipts r
        INNER JOIN receiptStatus t
        ON r.idLocal = t.idLocal
        WHERE t.statusSend_WhatsApp = 0
    ''';
    try {
      List<Map<dynamic, dynamic>> receipts1 = await receiptsDB.readData(sql);

      Get.find<ReceiptsNotSendByWhats>().setdata(receipts1);
      return receipts1;
    } catch (e) {
      Get.find<ReceiptsNotSendByWhats>().setdata([]);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ReceiptsNotSendByWhats());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorApp.primaryColor,
        title: const FittedBox(
          child: Text('الفواتير التي لم ترسل عبر الواتس'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _getReceiptNotSend,
          )
        ],
      ),
      body: FutureBuilder<List<Map<dynamic, dynamic>>>(
        future: _getReceiptNotSend(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: GetBuilder<ReceiptsNotSendByWhats>(
                    init: ReceiptsNotSendByWhats(),
                    builder: (controller) {
                      if (controller.receipts.isEmpty) {
                        return const EmptyWidgetResponse(
                            title: 'تحذير', content: 'لا يوجد بيانات');
                      } else {
                        return ListView.separated(
                          physics: const ScrollPhysics(),
                          itemCount: controller.receipts.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: IconButton(
                                onPressed: () {
                                  var id =
                                      controller.receipts[index]['idLocal'];
                                  File file = File(
                                      controller.receipts[index]['pathDB']);
                                  // PDFOpened.openFile(file);
                                  sendReceiptPdfByWhatsApp(file, id, context);
                                },
                                icon: const Icon(Icons.send),
                              ),
                              title:
                                  Text(controller.receipts[index]['whoIsTake']),
                              trailing: IconButton(
                                onPressed: () async {
                                  bool fileIsExists = await File(
                                          controller.receipts[index]['pathDB'])
                                      .exists();
                                  if (fileIsExists) {
                                    await PDFOpened.openFile(File(
                                        controller.receipts[index]['pathDB']));
                                  } else {
                                    File file = await ReceiptRepository()
                                        .downloadReceipt(
                                            controller.receipts[index]
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
                    }),
              );
            } else {
              return const EmptyWidgetResponse(
                  title: 'تحذير', content: 'لا يوجد بيانات');
            }
          }
        },
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
