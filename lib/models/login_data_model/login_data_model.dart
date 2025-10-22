import 'data.dart';

class LoginDataModel {
  Data? data;
  String? status;
  String? statusCode;

  LoginDataModel({this.data, this.status, this.statusCode});

  factory LoginDataModel.fromJson(Map<String, dynamic> json) {
    return LoginDataModel(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as String?,
      statusCode: json['statusCode'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'status': status,
        'statusCode': statusCode,
      };
}
