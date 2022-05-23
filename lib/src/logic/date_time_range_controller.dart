import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateTimeRangeController extends GetxController {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  DateTimeRange? dateTimeRange;

  @override
  void onInit() {
    startDate = DateTime.now();
    endDate = DateTime.now();
    dateTimeRange = DateTimeRange(start: startDate, end: endDate);
    super.onInit();
  }

  changedDateRange(startValue, endValue) async{
    startDate = startValue;
    endDate = endValue;
    dateTimeRange = DateTimeRange(start: startDate, end: endDate);
    update();
  }

  changeStart(startValue) {
    startDate = startValue;

    update();
  }

  changedEnd(endValue) {
    endDate = endValue;
    update();
  }
}
