import 'data.dart';

class EmployeeDataModel {
  Data? data;
  String? status;
  int? statusCode;
  String? dsec;

  EmployeeDataModel({this.data, this.status, this.statusCode, this.dsec});

  factory EmployeeDataModel.fromJson(Map<String, dynamic> json) {
    return EmployeeDataModel(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as String?,
      statusCode: json['statusCode'] as int?,
      dsec: json['dsec'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'status': status,
        'statusCode': statusCode,
        'dsec': dsec,
      };
}
