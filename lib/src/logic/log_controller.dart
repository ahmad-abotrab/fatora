import 'package:fatora/src/data/model/receipt_model.dart';
import 'package:fatora/src/data/repository/receipt_repository.dart';
import 'package:get/get.dart';

class LogController extends GetxController {
  List<Receipt>? receipts = [];
  var isLoading = false;
  var whatIsFail = '';


  fetchAllReceipt() async {
    try {
      await ReceiptRepository()
          .getAllReceipts()
          .then((value) => receipts = value);
      if (receipts!.isEmpty) {
        whatIsFail = 'لا يوجد بيانات في قاعدة البيانات';
      }
    } catch (e) {
      throw 'لا يوجد اتصال بالسيرفر';
    }
    update();
  }

  initializeList() async {
    receipts = await ReceiptRepository().getAllReceipts();

    update();
  }
}
