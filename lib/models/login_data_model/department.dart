import 'department_text.dart';

class Department {
  int? id;
  int? namesId;
  String? code;
  dynamic companyId;
  int? recordStatus;
  dynamic userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  DepartmentText? departmentText;

  Department({
    this.id,
    this.namesId,
    this.code,
    this.companyId,
    this.recordStatus,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.departmentText,
  });

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json['id'] as int?,
        namesId: json['names_id'] as int?,
        code: json['code'] as String?,
        companyId: json['company_id'] as dynamic,
        recordStatus: json['record_status'] as int?,
        userId: json['user_id'] as dynamic,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        departmentText: json['department_text'] == null
            ? null
            : DepartmentText.fromJson(
                json['department_text'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'names_id': namesId,
        'code': code,
        'company_id': companyId,
        'record_status': recordStatus,
        'user_id': userId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'department_text': departmentText?.toJson(),
      };
}
