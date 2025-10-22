import 'data.dart';

class ContractListHistoryModel {
  ContractData? data;
  String? status;
  int? statusCode;
  String? dsec;

  ContractListHistoryModel({
    this.data,
    this.status,
    this.statusCode,
    this.dsec,
  });

  factory ContractListHistoryModel.fromJson(Map<String, dynamic> json) {
    return ContractListHistoryModel(
      data: json['data'] == null
          ? null
          : ContractData.fromJson(json['data'] as Map<String, dynamic>),
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
