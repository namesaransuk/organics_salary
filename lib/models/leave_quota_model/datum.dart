import 'leave_used.dart';

class Datum {
  int? id;
  String? holidayNameType;
  dynamic description;
  int? detailCheck;
  int? fileUploadCheck;
  int? assignCheck;
  dynamic parentId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? limit;
  LeaveUsed? leaveUsed;

  Datum({
    this.id,
    this.holidayNameType,
    this.description,
    this.detailCheck,
    this.fileUploadCheck,
    this.assignCheck,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.limit,
    this.leaveUsed,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        holidayNameType: json['holiday_name_type'] as String?,
        description: json['description'] as dynamic,
        detailCheck: json['detail_check'] as int?,
        fileUploadCheck: json['file_upload_check'] as int?,
        assignCheck: json['assign_check'] as int?,
        parentId: json['parent_id'] as dynamic,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        limit: json['limit'] as String?,
        leaveUsed: json['leaveUsed'] == null
            ? null
            : LeaveUsed.fromJson(json['leaveUsed'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'holiday_name_type': holidayNameType,
        'description': description,
        'detail_check': detailCheck,
        'file_upload_check': fileUploadCheck,
        'assign_check': assignCheck,
        'parent_id': parentId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'limit': limit,
        'leaveUsed': leaveUsed?.toJson(),
      };
}
