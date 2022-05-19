class Receipt {
  String? id;
  String? whoIsTake;
  String? amountText;
  String? amountNumeric;
  String? causeOfPayment;
  String? date;

  Receipt({
    this.id,
    this.whoIsTake,
    this.amountText,
    this.amountNumeric,
    this.causeOfPayment,
    this.date,
  });

  Receipt.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    whoIsTake = json['whoIsTake'];
    amountText = json['amountText'];
    amountNumeric = json['amountNumeric'];
    causeOfPayment = json['causeOfPayment'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['whoIsTake'] = whoIsTake;
    data['amountText'] = amountText;
    data['amountNumeric'] = amountNumeric!;
    data['causeOfPayment'] = causeOfPayment;
    data['date'] = date;
    return data;
  }

  sout() {
    print(id);
    print("\n");
    print(whoIsTake);
    print("\n");
    print(amountNumeric);
    print("\n");
    print(amountText);
    print("\n");
    print(causeOfPayment);
    print("\n");
  }
}
