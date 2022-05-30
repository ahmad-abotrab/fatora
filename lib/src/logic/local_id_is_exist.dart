import 'package:get/get.dart';

import '../data/model/local_id_for_receipt.dart';
import '../data/repository/receipt_repository.dart';

class LocalIdIsExits extends GetxController
  with StateMixin<LocalIdForReceipt> {
  LocalIdForReceipt? localIdForReceipt;


  @override
  void onReady() {
  localIdForReceipt = LocalIdForReceipt();

  fetchId();
  super.onReady();

  }

  fetchId() async {
  try {
  change(null, status: RxStatus.loading());
  localIdForReceipt = LocalIdForReceipt();

  ReceiptRepository().createNewLocalCharID().then((value) {

  localIdForReceipt = LocalIdForReceipt();
  localIdForReceipt = value;
  change(localIdForReceipt, status: RxStatus.success());
  }, onError: (err) {

  change(null, status: RxStatus.error(err.toString()));
  });
  } catch (exception) {

  change(null, status: RxStatus.error(exception.toString()));
  }
  }
}