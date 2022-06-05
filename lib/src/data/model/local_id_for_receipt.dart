class LocalIdForReceipt {
  String? charReceiptForEachEmployee;
  String? idReceiptForEachEmployee;
  bool? isThere;


  LocalIdForReceipt({
    this.charReceiptForEachEmployee,
    this.idReceiptForEachEmployee,
    this.isThere,

  });
  LocalIdForReceipt.fromJson(Map<String,dynamic>json){
    charReceiptForEachEmployee = json['charReceiptForEachEmployee'];
    idReceiptForEachEmployee = json['idReceiptForEachEmployee'];
    isThere = json['isThere'];

  }
  Map<String,dynamic> toJson(){
    Map<String,dynamic> data = <String,dynamic>{};
    data['charReceiptForEachEmployee'] = charReceiptForEachEmployee;
    data['idReceiptForEachEmployee'] = idReceiptForEachEmployee;
    data['isThere'] = isThere;
    return data;
  }
}
