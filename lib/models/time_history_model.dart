import 'dart:convert';

class TimeHistoryModel {
  String? id;
  String? date;
  String? time;

  TimeHistoryModel({this.id, this.date, this.time});

  factory TimeHistoryModel.fromMap(Map<String, dynamic> json) {
    return TimeHistoryModel(
      id: json['id'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'date': date,
        'time': time,
      };

  factory TimeHistoryModel.fromJson(String data) {
    return TimeHistoryModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
