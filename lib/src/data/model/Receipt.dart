/// whoIsTake : "String"
/// whoIsPay : "String"
/// amount : "double"
/// causeOfAmount : "String"

class Receipt {
  String? whoIsTake;
  String? amountText;
  double? amount;
  String? causeOfAmount;

  Receipt({
    required String? whoIsTake,
    required String? amountText,
    required double? amount,
    required String? causeOfAmount,
  }) {
    whoIsTake = whoIsTake!;
    amountText = amountText!;
    amount = amount!;
    causeOfAmount = causeOfAmount!;
  }

  Receipt.fromJson(dynamic json) {
    whoIsTake = json['whoIsTake'];
    amountText = json['amountText'];
    amount = json['amount'];
    causeOfAmount = json['causeOfAmount'];
  }

  Receipt copyWith({
    String? whoIsTake,
    String? amountText,
    double? amount,
    String? causeOfAmount,
  }) =>
      Receipt(
        whoIsTake: whoIsTake ?? whoIsTake,
        amountText: amountText ?? amountText,
        amount: amount ?? amount,
        causeOfAmount: causeOfAmount ?? causeOfAmount,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['whoIsTake'] = whoIsTake;
    map['amountText'] = amountText;
    map['amount'] = amount;
    map['causeOfAmount'] = causeOfAmount;
    return map;
  }
}
