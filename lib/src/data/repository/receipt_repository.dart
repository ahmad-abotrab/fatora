import '/src/data/model/Receipt.dart';
import '../server/receipt_api.dart';

class ReceiptRepository {
  Future<List<Receipt>> getAllReceipts() async {
    final receipts = await ReceiptApi().getAllReceipt();
    return receipts.map((character) => Receipt.fromJson(character)).toList();
  }

  Future<dynamic> addNewReceipt(Receipt receipt) async {
    final response = await ReceiptApi().addNewReceipt(receipt.toJson());
    print(response);
  }

  Future<dynamic> getLastId() async {
    final response = await ReceiptApi().getLastId();
    print(response);
  }
}
