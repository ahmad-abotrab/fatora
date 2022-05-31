
import '/src/data/model/local_id_for_receipt.dart';
import 'package:get/get.dart';

class ReceiptsNotSendByWhats extends GetxController {

  List<Map<dynamic, dynamic>> receipts = [];

  @override
  void onReady() {
    receipts = [];
    super.onReady();

  }

  setdata(value)  {
    receipts = value;
    update();
  }

}
