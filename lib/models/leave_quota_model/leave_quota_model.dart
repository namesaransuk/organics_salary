import 'datum.dart';
import 'status.dart';

class LeaveQuotaModel {
  Status? status;
  String? statusCode;
  List<Datum>? data;

  LeaveQuotaModel({this.status, this.statusCode, this.data});

  factory LeaveQuotaModel.fromJson(Map<String, dynamic> json) {
    return LeaveQuotaModel(
      status: json['status'] == null
          ? null
          : Status.fromJson(json['status'] as Map<String, dynamic>),
      statusCode: json['statusCode'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status?.toJson(),
        'statusCode': statusCode,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
