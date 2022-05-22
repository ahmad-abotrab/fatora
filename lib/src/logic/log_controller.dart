import 'package:fatora/src/data/model/receipt_model.dart';
import 'package:get/get.dart';

class LogController extends GetxController {
  List<Receipt>? receipts;

  @override
  void onInit() {
    receipts = [];
    super.onInit();
  }

  updateReceiptsList(List<Receipt> receipt) {
    receipts = receipt;
    update();
  }
}
