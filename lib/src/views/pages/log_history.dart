import 'package:flutter/material.dart';

import '/src/Constant/color_app.dart';
import '/src/views/components/empty_widget_response.dart';
import '../../data/model/receipt_model.dart';

class LogHistory extends StatelessWidget {
  const LogHistory({
    Key? key,
    required this.receipts,
  }) : super(key: key);
  final List<Receipt> receipts;

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
        child: receipts.isEmpty
            ? const EmptyWidgetResponse(
                title: 'امممممم', content: 'لا يوجد بيانات')
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: buildColumnTable(),
                  rows: buildRowTable(receipts),
                ),
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
            DataCell(
              Text(
                receipts[i].date!.year.toString() +
                    ":" +
                    receipts[i].date!.month.toString() +
                    ":" +
                    receipts[i].date!.day.toString() +
                    "/" +
                    receipts[i].date!.hour.toString() +
                    ":" +
                    receipts[i].date!.minute.toString(),
              ),
            ),
          ],
        ),
      );
    }
    return rows;
  }
}
