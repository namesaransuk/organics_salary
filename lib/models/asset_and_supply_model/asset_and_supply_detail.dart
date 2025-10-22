import 'image.dart';
import 'requests_type.dart';
import 'store_summary.dart';

class AssetAndSupplyDetail {
  int? id;
  int? empId;
  int? userId;
  int? companyId;
  int? departmentId;
  String? amount;
  int? assetsAndSupplyId;
  String? details;
  String? note1;
  dynamic note2;
  int? transactionRequestsId;
  int? action;
  String? actionName;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  RequestsType? requestsType;
  StoreSummary? storeSummary;
  Image? image;

  AssetAndSupplyDetail({
    this.id,
    this.empId,
    this.userId,
    this.companyId,
    this.departmentId,
    this.amount,
    this.assetsAndSupplyId,
    this.details,
    this.note1,
    this.note2,
    this.transactionRequestsId,
    this.action,
    this.actionName,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.requestsType,
    this.storeSummary,
    this.image,
  });

  factory AssetAndSupplyDetail.fromJson(Map<String, dynamic> json) {
    return AssetAndSupplyDetail(
      id: json['id'] as int?,
      empId: json['emp_id'] as int?,
      userId: json['user_id'] as int?,
      companyId: json['company_id'] as int?,
      departmentId: json['department_id'] as int?,
      amount: json['amount'] as String?,
      assetsAndSupplyId: json['assets_and_supply_id'] as int?,
      details: json['details'] as String?,
      note1: json['note1'] as String?,
      note2: json['note2'] as dynamic,
      transactionRequestsId: json['transaction_requests_id'] as int?,
      action: json['action'] as int?,
      actionName: json['action_name'] as String?,
      status: json['status'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      requestsType: json['requests_type'] == null
          ? null
          : RequestsType.fromJson(
              json['requests_type'] as Map<String, dynamic>),
      storeSummary: json['store_summary'] == null
          ? null
          : StoreSummary.fromJson(
              json['store_summary'] as Map<String, dynamic>),
      image: json['image'] == null
          ? null
          : Image.fromJson(json['image'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'emp_id': empId,
        'user_id': userId,
        'company_id': companyId,
        'department_id': departmentId,
        'amount': amount,
        'assets_and_supply_id': assetsAndSupplyId,
        'details': details,
        'note1': note1,
        'note2': note2,
        'transaction_requests_id': transactionRequestsId,
        'action': action,
        'action_name': actionName,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'requests_type': requestsType?.toJson(),
        'store_summary': storeSummary?.toJson(),
        'image': image?.toJson(),
      };
}
