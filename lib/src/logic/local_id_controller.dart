// import '/src/data/model/local_id_for_receipt.dart';
// import '/src/data/repository/receipt_repository.dart';
// import 'package:get/get.dart';
//
// class LocalIdController extends GetxController
//     with StateMixin<LocalIdForReceipt> {
//   LocalIdForReceipt? localIdForReceipt;
//
//
//   @override
//   void onReady() {
//     localIdForReceipt = LocalIdForReceipt();
//
//     fetchId();
//     super.onReady();
//
//   }
//
//   fetchId(id) async {
//     try {
//       change(null, status: RxStatus.loading());
//       localIdForReceipt = LocalIdForReceipt();
//
//       ReceiptRepository().checkIfThereId(id).then((value) {
//
//         localIdForReceipt = LocalIdForReceipt();
//         localIdForReceipt.isThere = value;
//         change(localIdForReceipt, status: RxStatus.success());
//       }, onError: (err) {
//
//         change(null, status: RxStatus.error(err.toString()));
//       });
//     } catch (exception) {
//
//       change(null, status: RxStatus.error(exception.toString()));
//     }
//   }
// }
