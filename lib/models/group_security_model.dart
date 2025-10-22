class GroupSecurityModel {
  int? id;
  String? empId;
  String? groupInsuranceImg;
  String? recordStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  GroupSecurityModel({
    this.id,
    this.empId,
    this.groupInsuranceImg,
    this.recordStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory GroupSecurityModel.fromJson(Map<String, dynamic> json) {
    return GroupSecurityModel(
      id: json['id'] as int?,
      empId: json['emp_id'] as String?,
      groupInsuranceImg: json['group_insurance_img'] as String?,
      recordStatus: json['record_status'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'emp_id': empId,
        'group_insurance_img': groupInsuranceImg,
        'record_status': recordStatus,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
