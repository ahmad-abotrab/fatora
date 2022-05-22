import 'package:get/get.dart';

class DateTimeRangeController extends GetxController {
  var startDate = DateTime.now();
  var endDate = DateTime.now();

  @override
  void onInit() {
    startDate = DateTime.now();
    endDate = DateTime.now();
    super.onInit();
  }

  changedDateRange(startValue, endValue) {
    startDate = startValue;
    endDate = endValue;
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
