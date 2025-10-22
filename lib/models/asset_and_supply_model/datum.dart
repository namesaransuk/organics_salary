import 'asset_and_supply_detail.dart';
import 'status_route.dart';

class Datum {
  int? id;
  int? empId;
  dynamic recipientId;
  dynamic companyId;
  String? moduleName;
  dynamic moduleActionId;
  dynamic subject;
  String? detail;
  dynamic note1;
  dynamic note2;
  int? imageShowId;
  int? requestsGroupId;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  StatusRoute? statusRoute;
  AssetAndSupplyDetail? assetAndSupplyDetail;

  Datum({
    this.id,
    this.empId,
    this.recipientId,
    this.companyId,
    this.moduleName,
    this.moduleActionId,
    this.subject,
    this.detail,
    this.note1,
    this.note2,
    this.imageShowId,
    this.requestsGroupId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.statusRoute,
    this.assetAndSupplyDetail,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        empId: json['emp_id'] as int?,
        recipientId: json['recipient_id'] as dynamic,
        companyId: json['company_id'] as dynamic,
        moduleName: json['module_name'] as String?,
        moduleActionId: json['module_action_id'] as dynamic,
        subject: json['subject'] as dynamic,
        detail: json['detail'] as String?,
        note1: json['note1'] as dynamic,
        note2: json['note2'] as dynamic,
        imageShowId: json['image_show_id'] as int?,
        requestsGroupId: json['requests_group_id'] as int?,
        status: json['status'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        statusRoute: json['status_route'] == null
            ? null
            : StatusRoute.fromJson(
                json['status_route'] as Map<String, dynamic>),
        assetAndSupplyDetail: json['asset_and_supply_detail'] == null
            ? null
            : AssetAndSupplyDetail.fromJson(
                json['asset_and_supply_detail'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'emp_id': empId,
        'recipient_id': recipientId,
        'company_id': companyId,
        'module_name': moduleName,
        'module_action_id': moduleActionId,
        'subject': subject,
        'detail': detail,
        'note1': note1,
        'note2': note2,
        'image_show_id': imageShowId,
        'requests_group_id': requestsGroupId,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'status_route': statusRoute?.toJson(),
        'asset_and_supply_detail': assetAndSupplyDetail?.toJson(),
      };
}
