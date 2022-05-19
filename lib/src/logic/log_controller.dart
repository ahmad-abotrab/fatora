import 'package:fatora/src/data/model/Receipt.dart';
import 'package:fatora/src/data/repository/receipt_repository.dart';
import 'package:get/get.dart';

class LogController extends GetxController {
  List<Receipt>? receipts = [];
  var isLoading = false;

  @override
  void onReady() {
    // fetchAllReceipt();
    super.onReady();
  }

  @override
  void onInit() {
    fetchAllReceipt();
    super.onInit();
  }

  fetchAllReceipt() async {
    receipts = await ReceiptRepository().getAllReceipts();
    if (receipts!.isEmpty) {
      isLoading = false;
    } else {
      isLoading = true;
    }
    update();
  }

  initializeList() async {
    receipts = await ReceiptRepository().getAllReceipts();
    ;
    update();
  }
}
