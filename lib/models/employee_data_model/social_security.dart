import 'sso_detail.dart';
import 'sso_doc.dart';
import 'status_assigner_data.dart';
import 'status_follower_data.dart';
import 'status_logs.dart';

class SocialSecurity {
  int? id;
  int? empId;
  dynamic recipientId;
  int? companyId;
  String? moduleName;
  String? moduleActionId;
  String? subject;
  String? detail;
  String? note1;
  String? note2;
  int? imageShowId;
  int? requestsGroupId;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  StatusFollowerData? statusFollowerData;
  StatusAssignerData? statusAssignerData;
  SsoDetail? ssoDetail;
  StatusLogs? statusLogs;
  List<SsoDoc>? ssoDoc;

  SocialSecurity({
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
    this.statusFollowerData,
    this.statusAssignerData,
    this.ssoDetail,
    this.statusLogs,
    this.ssoDoc,
  });

  factory SocialSecurity.fromJson(Map<String, dynamic> json) {
    return SocialSecurity(
      id: json['id'] as int?,
      empId: json['emp_id'] as int?,
      recipientId: json['recipient_id'] as dynamic,
      companyId: json['company_id'] as int?,
      moduleName: json['module_name'] as String?,
      moduleActionId: json['module_action_id'] as String?,
      subject: json['subject'] as String?,
      detail: json['detail'] as String?,
      note1: json['note1'] as String?,
      note2: json['note2'] as String?,
      imageShowId: json['image_show_id'] as int?,
      requestsGroupId: json['requests_group_id'] as int?,
      status: json['status'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      statusFollowerData: json['status_follower_data'] == null
          ? null
          : StatusFollowerData.fromJson(
              json['status_follower_data'] as Map<String, dynamic>),
      statusAssignerData: json['status_assigner_data'] == null
          ? null
          : StatusAssignerData.fromJson(
              json['status_assigner_data'] as Map<String, dynamic>),
      ssoDetail: json['sso_detail'] == null
          ? null
          : SsoDetail.fromJson(json['sso_detail'] as Map<String, dynamic>),
      statusLogs: json['status_logs'] == null
          ? null
          : StatusLogs.fromJson(json['status_logs'] as Map<String, dynamic>),
      ssoDoc: (json['sso_doc'] as List<dynamic>?)
          ?.map((e) => SsoDoc.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

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
        'status_follower_data': statusFollowerData?.toJson(),
        'status_assigner_data': statusAssignerData?.toJson(),
        'sso_detail': ssoDetail?.toJson(),
        'status_logs': statusLogs?.toJson(),
        'sso_doc': ssoDoc?.map((e) => e.toJson()).toList(),
      };
}
