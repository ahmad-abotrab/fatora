import 'package:get/get.dart';

import '../../receipts_db.dart';

class WhatsAppNotSent extends GetxController{
  List<Map> receiptsNotSend = [];
  ReceiptsDB receiptsDB = ReceiptsDB();

  void onInit() async{
    await getReceiptNotSend();
    super.onInit();
  }
  getReceiptNotSend() async {
    String sql = '''
        SELECT r.whoIsTake, t.pathDB, r.idLocal , r.receiptPdfFileName
        FROM receipts r
        INNER JOIN receiptStatus t
        ON r.idLocal = t.idLocal
        WHERE statusSend_WhatsApp = 0
    ''';
    receiptsNotSend = await receiptsDB.readData(sql);
  }
  uploadList(sql,data)async{
    await receiptsDB.updateData(sql, data);
    await getReceiptNotSend();
    update();
  }
}