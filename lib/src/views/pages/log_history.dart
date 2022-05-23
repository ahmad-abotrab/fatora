import 'package:fatora/src/logic/date_time_range_controller.dart';
import 'package:fatora/src/logic/log_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/loading_widget.dart';
import '/src/Constant/color_app.dart';
import '/src/views/components/empty_widget_response.dart';
import '../../data/model/receipt_model.dart';
import '../../data/repository/receipt_repository.dart';
import '../components/dialog_loading.dart';

// ignore: must_be_immutable
class LogHistory extends StatelessWidget {
  LogHistory({
    Key? key,
  }) : super(key: key);

  final List<String> tableName = [
    'رقم',
    'القابض',
    'المبلغ',
    'السبب',
    'التاريخ'
  ];
  late GlobalKey<State> keyLoader = GlobalKey<State>();
  @override
  Widget build(BuildContext context) {
    keyLoader = GlobalKey<State>();
    _refresh() async {
      try {
        await ReceiptRepository().getAllReceipts().then(
            (value) => Get.find<LogController>().updateReceiptsList(value));
      } catch (e) {
        showDialog(
          context: context,
          builder: (_) => DialogLoading(
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
        child: SingleChildScrollView(
          child: Get.find<LogController>().receipts!.isEmpty
              ? const EmptyWidgetResponse(
                  title: 'امممممم', content: 'لا يوجد بيانات')
              : GetBuilder<LogController>(
                  init: LogController(),
                  builder: (controller) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: buildColumnTable(),
                        rows: buildRowTable(controller.receipts!),
                      ),
                    );
                  }),
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
    try{

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

    }catch(e){
      Navigator.of(context, rootNavigator: true).pop();
      showDialog(
        context: context,
        builder: (_) => DialogLoading(
          content:
          e.toString() ,
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
