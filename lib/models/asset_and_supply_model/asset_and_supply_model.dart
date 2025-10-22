import 'datum.dart';

class AssetAndSupplyModel {
  List<Datum>? data;
  String? status;
  int? statusCode;
  String? dsec;

  AssetAndSupplyModel({this.data, this.status, this.statusCode, this.dsec});

  factory AssetAndSupplyModel.fromJson(Map<String, dynamic> json) {
    return AssetAndSupplyModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      statusCode: json['statusCode'] as int?,
      dsec: json['dsec'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => e.toJson()).toList(),
        'status': status,
        'statusCode': statusCode,
        'dsec': dsec,
      };
}
