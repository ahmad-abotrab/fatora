import '../../receipts_db.dart';
import '/src/data/model/local_id_for_receipt.dart';
import '/src/data/repository/receipt_repository.dart';
import 'package:get/get.dart';

class ReceiptsNotSendByWhats extends GetxController
    with StateMixin<LocalIdForReceipt> {
  LocalIdForReceipt? localIdForReceipt;


  @override
  void onReady() {
    fetchId();
    super.onReady();

  }

  fetchId() async {
    try {
      change(null, status: RxStatus.loading());

      change(localIdForReceipt, status: RxStatus.success());
    } catch (exception) {

      change(null, status: RxStatus.error(exception.toString()));
    }
  }
}
