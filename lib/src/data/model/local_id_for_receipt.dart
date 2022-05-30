class LocalIdForReceipt {
  String? charReceiptForEachEmployee;
  String? idReceiptForEachEmployee;


  LocalIdForReceipt({
    this.charReceiptForEachEmployee,
    this.idReceiptForEachEmployee,

  });
  LocalIdForReceipt.fromJson(Map<String,dynamic>json){
    charReceiptForEachEmployee = json['charReceiptForEachEmployee'];
    idReceiptForEachEmployee = json['idReceiptForEachEmployee'];

  }
  Map<String,dynamic> toJson(){
    Map<String,dynamic> data = <String,dynamic>{};
    data['charReceiptForEachEmployee'] = charReceiptForEachEmployee;
    data['idReceiptForEachEmployee'] = idReceiptForEachEmployee;
    return data;
  }
}
