import 'package:fatora/src/data/model/receipt_model.dart';
import 'package:fatora/src/data/repository/receipt_repository.dart';
import 'package:get/get.dart';

class LogController extends GetxController {
  List<Receipt>? receipts = [];
  var isLoading = false;
  var whatIsFail = '';


  @override
  void onInit() {
    fetchAllReceipt();
    super.onInit();
  }

  fetchAllReceipt() async {
    try  {
      final result = await ReceiptRepository().getAllReceipts();
      if (result.isEmpty) {
        isLoading = false;
        whatIsFail = 'لا يوجد بيانات في قاعدة البيانات';
      } else {
        receipts = result.map((e) => Receipt.fromJson(e));
        isLoading = true;
      }
    } catch (e) {
      isLoading = false;
      whatIsFail = 'قد لا تكون متصل بالانترنت أو أن السيرفر معطل';
    }
    update();
  }

  initializeList() async {
    receipts = await ReceiptRepository().getAllReceipts();
    
    update();
  }
}
