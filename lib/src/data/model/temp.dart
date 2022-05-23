class Temp {
  DateTime? startDate;
  DateTime? endDate;

  Temp({
    this.startDate,
    this.endDate,
  });

  Temp.fromJson(Map<String, dynamic> json) {
    startDate = DateTime.parse(json['startDate']);
    endDate = DateTime.parse(json['endDate']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['startDate'] = startDate!.toIso8601String();
    data['endDate'] = endDate!.toIso8601String();
    return data;
  }
}
