
class Receipt {
  String? idLocal;
  String? whoIsTake;
  String? amountText;
  String? amountNumeric;
  String? causeOfPayment;
  DateTime? date;
  String? receiptPdfFileName;
  int? statusSend_WhatsApp =0;


  Receipt({
    this.idLocal,
    this.whoIsTake,
    this.amountText,
    this.amountNumeric,
    this.causeOfPayment,
    this.date,
    this.receiptPdfFileName,
    this.statusSend_WhatsApp =0
  });

  Receipt.fromJson(Map<String, dynamic> json) {
    idLocal = json['idLocal'];
    whoIsTake = json['whoIsTake'];
    amountText = json['amountText'];
    amountNumeric = json['amountNumeric'];
    causeOfPayment = json['causeOfPayment'];
    receiptPdfFileName = json['receiptPdfFileName'];
    statusSend_WhatsApp = json['statusSend_WhatsApp'];
    date = DateTime.parse(json['date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idLocal'] = idLocal;
    data['whoIsTake'] = whoIsTake;
    data['amountText'] = amountText;
    data['amountNumeric'] = amountNumeric!;
    data['causeOfPayment'] = causeOfPayment;
    data['receiptPdfFileName'] = receiptPdfFileName;
    data['statusSend_WhatsApp'] = statusSend_WhatsApp;
    data['date'] = date!.toIso8601String();
    return data;
  }

}
