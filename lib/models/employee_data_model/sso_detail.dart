import 'system_image.dart';

class SsoDetail {
  int? id;
  String? name;
  String? detail;
  dynamic companyId;
  dynamic positionId;
  dynamic departmentId;
  dynamic gender;
  String? imageSystemId;
  DateTime? createdAt;
  DateTime? updatedAt;
  SystemImage? systemImage;

  SsoDetail({
    this.id,
    this.name,
    this.detail,
    this.companyId,
    this.positionId,
    this.departmentId,
    this.gender,
    this.imageSystemId,
    this.createdAt,
    this.updatedAt,
    this.systemImage,
  });

  factory SsoDetail.fromJson(Map<String, dynamic> json) => SsoDetail(
        id: json['id'] as int?,
        name: json['name'] as String?,
        detail: json['detail'] as String?,
        companyId: json['company_id'] as dynamic,
        positionId: json['position_id'] as dynamic,
        departmentId: json['department_id'] as dynamic,
        gender: json['gender'] as dynamic,
        imageSystemId: json['image_system_id'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        systemImage: json['system_image'] == null
            ? null
            : SystemImage.fromJson(
                json['system_image'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'detail': detail,
        'company_id': companyId,
        'position_id': positionId,
        'department_id': departmentId,
        'gender': gender,
        'image_system_id': imageSystemId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'system_image': systemImage?.toJson(),
      };
}
