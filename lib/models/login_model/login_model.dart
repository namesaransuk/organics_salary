import 'data.dart';

class LoginModel {
  DataModel? data;
  String? status;
  String? statusCode;

  LoginModel({this.data, this.status, this.statusCode});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        data: json['data'] == null
            ? null
            : DataModel.fromJson(json['data'] as Map<String, dynamic>),
        status: json['status'] as String?,
        statusCode: json['statusCode'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'status': status,
        'statusCode': statusCode,
      };
}
