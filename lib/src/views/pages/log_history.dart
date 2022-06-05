import 'dart:async';
import 'dart:io';

import 'package:fatora/receipts_db.dart';
import 'package:fatora/src/data/web_services/pdf_opened.dart';
import 'package:fatora/src/views/pages/pdf_viewer_local.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '/src/Constant/color_app.dart';
import '/src/logic/date_time_range_controller.dart';
import '/src/logic/log_controller.dart';
import '/src/views/components/empty_widget_response.dart';
import '../../data/model/receipt_model.dart';
import '../../data/repository/receipt_repository.dart';
import '../components/dialog_loading.dart';
import '../components/loading_widget.dart';

// ignore: must_be_immutable
class LogHistory extends StatefulWidget {
  const LogHistory({
    Key? key,
  }) : super(key: key);

  @override
  State<LogHistory> createState() => _LogHistoryState();
}

class _LogHistoryState extends State<LogHistory> {
  final List<String> tableName = [
    'رقم',
    'القابض',
    'المبلغ',
    'السبب',
    'التاريخ',
    'المزيد',
  ];

  late GlobalKey<State> keyLoader = GlobalKey<State>();

  var dateTimeController = Get.put(DateTimeRangeController(), permanent: true);

  ReceiptsDB receiptDB = ReceiptsDB();

  @override
  Widget build(BuildContext context) {
    keyLoader = GlobalKey<State>();
    _refresh() async {
      try {
        await ReceiptRepository()
            .getReceiptsBetweenRangeDate(
                dateTimeController.startDate, dateTimeController.endDate)
            .then(
                (value) => Get.find<LogController>().updateReceiptsList(value));
      } catch (e) {
        showDialog(
          context: context,
          builder: (_) => WarningDialog(
            content: e.toString(),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorApp.primaryColor,
        title: const FittedBox(
          child: Text('السجل'),
        ),
        actions: [
          dateTimeRangeUI(context),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Get.find<LogController>().receipts!.isEmpty
            ? const EmptyWidgetResponse(
                title: 'امممممم', content: 'لا يوجد بيانات')
            : GetBuilder<LogController>(
                init: LogController(),
                builder: (controller) {
                  return RefreshIndicator(
                    onRefresh: _refresh,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          // headingRowHeight: 10,
                          dividerThickness: 5,
                          columns: buildColumnTable(),
                          rows: buildRowTable(controller.receipts!),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  dateTimeRangeUI(context) {
    return GetBuilder<DateTimeRangeController>(
        init: DateTimeRangeController(),
        builder: (controllerBasic) {
          return TextButton(
            onPressed: () => pickerDateRange(
              context,
              controllerBasic.dateTimeRange,
              DateTime(2020),
              DateTime(2050),
            ),
            child: GetBuilder<DateTimeRangeController>(
                init: DateTimeRangeController(),
                builder: (controller) {
                  return Text(
                    formatDate(controller.startDate) +
                        "    " +
                        formatDate(controller.endDate),
                    style: const TextStyle(color: Colors.white),
                  );
                }),
          );
        });
  }

  Future pickerDateRange(
      context, initialDateTimeRange, startDate, endDate) async {
    DateTimeRange? dateTimeRange = await showDateRangePicker(
      context: context,
      initialDateRange: initialDateTimeRange,
      firstDate: startDate,
      lastDate: endDate,
    );
    if (dateTimeRange == null) return;
    Get.find<DateTimeRangeController>()
        .changedDateRange(dateTimeRange.start, dateTimeRange.end);
    try {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => LoadingWidget(
                keyLoader: keyLoader,
              ));

      await ReceiptRepository()
          .getReceiptsBetweenRangeDate(dateTimeRange.start, dateTimeRange.end)
          .then((value) => Get.find<LogController>().updateReceiptsList(value));
      Navigator.of(context, rootNavigator: true).pop();
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      showDialog(
        context: context,
        builder: (_) => WarningDialog(
          content: e.toString(),
        ),
      );
    }
  }

  formatDate(DateTime dateTime) {
    return dateTime.year.toString() +
        ":" +
        dateTime.month.toString() +
        ":" +
        dateTime.day.toString();
  }

  getSingleDataColumnWidget(String valueLabel) {
    return DataColumn(
      label: Directionality(
        textDirection: TextDirection.rtl,
        child: Text(valueLabel),
      ),
    );
  }

  buildColumnTable() {
    List<DataColumn> columns = [];
    for (int i = 0; i < tableName.length; i++) {
      columns.add(getSingleDataColumnWidget(tableName[i]));
    }
    return columns;
  }

  buildRowTable(List<Receipt> receipts) {
    List<DataRow> rows = [];
    for (int i = 0; i < receipts.length; i++) {
      rows.add(
        DataRow(
          cells: [
            DataCell(Text(receipts[i].idLocal.toString())),
            DataCell(Text(receipts[i].whoIsTake ?? "لايوجد")),
            DataCell(Text(receipts[i].amountNumeric.toString() == 'null'
                ? "لايوجد"
                : receipts[i].amountNumeric.toString())),
            DataCell(Text(receipts[i].causeOfPayment ?? "لايوجد")),
            DataCell(
              Text(
                receipts[i].date!.year.toString() +
                    "-" +
                    receipts[i].date!.month.toString() +
                    "-" +
                    receipts[i].date!.day.toString() +
                    ":" +
                    receipts[i].date!.hour.toString() +
                    "-" +
                    receipts[i].date!.minute.toString(),
              ),
            ),
            DataCell(popButton(receipts[i]))
          ],
        ),
      );
    }
    return rows;
  }

  popButton(Receipt receipt) {
    return PopupMenuButton(
      offset: Offset.fromDirection(20.0),
      icon: const Icon(Icons.more_horiz_outlined),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () async {
            var pathFile = (await getApplicationDocumentsDirectory()).path;
            var fullPath = pathFile + '/' + receipt.receiptPdfFileName!;
            var fileIsExists = await File(fullPath).exists();
            if (fileIsExists) {
              File file = File(fullPath);
              await PDFOpened.openFile(file);
            } else {
                Navigator.push(context, MaterialPageRoute(builder: (_)=>PdfViewerLocal(fileName: receipt.receiptPdfFileName!)));
            }
          },
          child: Row(
            children: const [
              Text(
                'عرض',
                style: TextStyle(color: Colors.black),
              ),
              Expanded(child: SizedBox()),
              FaIcon(FontAwesomeIcons.filePdf, color: Colors.red),
            ],
          ),
        ),
        PopupMenuItem(
          onTap: () async {
            var pathFile = (await getApplicationDocumentsDirectory()).path;
            var fullPath = pathFile + '/' + receipt.receiptPdfFileName!;
            var fileIsExists = await File(fullPath).exists();
            if (fileIsExists) {
              File file = File(fullPath);
              sendReceiptPdfByWhatsApp(file, receipt.idLocal);
            } else {

              File file = await ReceiptRepository()
                  .downloadReceipt(receipt.receiptPdfFileName!);
              sendReceiptPdfByWhatsApp(file, receipt.idLocal);
            }
          },
          child: Row(
            children: const [
              Text(
                'إرسال الملف عبر',
                style: TextStyle(color: Colors.black),
              ),
              Expanded(child: SizedBox()),
              Icon(Icons.share ,color: Colors.blue,),
            ],
          ),
        ),
      ],
    );
  }

  sendReceiptPdfByWhatsApp(file, id) async {
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
      await receiptDB.updateData(sql, data);
    } else {
      String sql = '''
                  UPDATE receiptStatus
                  SET statusSend_WhatsApp = ?
                  WHERE idLocal = ?;
                  ''';
      List data = [0, id];
      await receiptDB.updateData(sql, data);
    }
  }
}
