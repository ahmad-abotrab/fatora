import 'package:empty_widget/empty_widget.dart';
import '/src/Constant/color_app.dart';
import '/src/logic/log_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/Receipt.dart';

class LogHistory extends StatelessWidget {
  LogHistory({Key? key}) : super(key: key);

  // var controllerLogHistory = Get.put<LogController>(LogController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorApp.primaryColor,
        title: const FittedBox(
          child: Text('السجل'),
        ),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<LogController>(
          init: LogController(),
          builder: (controller) {
            return controller.isLoading
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: buildColumnTable(),
                      rows: buildRowTable(controller.receipts!),
                    ),
                  )
                : Container(
                    alignment: Alignment.center,
                    child: EmptyWidget(
                      image: null,
                      packageImage: PackageImage.Image_1,
                      title: 'لا يوجد بيانات',
                      subTitle: controller.whatIsFail,
                      titleTextStyle: const TextStyle(
                        fontSize: 22,
                        color: Color(0xff9da9c7),
                        fontWeight: FontWeight.w500,
                      ),
                      subtitleTextStyle: const TextStyle(
                        fontSize: 14,
                        color: Color(0xffabb8d6),
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }

  buildColumnTable() {
    return const [
      DataColumn(
        label: Directionality(
          textDirection: TextDirection.rtl,
          child: Text('رقم'),
        ),
      ),
      DataColumn(
        label: Directionality(
          textDirection: TextDirection.rtl,
          child: Text('القابض'),
        ),
      ),
      DataColumn(
        label: Directionality(
          textDirection: TextDirection.rtl,
          child: Text('المبلغ'),
        ),
      ),
      DataColumn(
        label: Directionality(
          textDirection: TextDirection.rtl,
          child: Text('السبب'),
        ),
      ),
      DataColumn(
        label: Directionality(
          textDirection: TextDirection.rtl,
          child: Text('التاريخ'),
        ),
      ),
    ];
  }

  buildRowTable(List<Receipt> receipts) {
    List<DataRow> rows = [];
    for (int i = 0; i < receipts.length; i++) {
      rows.add(
        DataRow(
          cells: [
            DataCell(Text(receipts[i].id.toString())),
            DataCell(Text(receipts[i].whoIsTake ?? "لايوجد")),
            DataCell(Text(receipts[i].amountNumeric.toString() == 'null'
                ? "لايوجد"
                : receipts[i].amountNumeric.toString())),
            DataCell(Text(receipts[i].causeOfPayment ?? "لايوجد")),
            DataCell(Text(receipts[i].date ?? "لايوجد")),
          ],
        ),
      );
    }
    return rows;
  }
}
