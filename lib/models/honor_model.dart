class HonorModel {
  int? id;
  int? empId;
  String? honorCategoryId;
  int? companyId;
  int? positionId;
  int? departmentId;
  String? honorImg;
  String? honorDetail;
  String? approveStatus;
  String? recordStatus;
  dynamic createdAt;
  dynamic updatedAt;

  HonorModel({
    this.id,
    this.empId,
    this.honorCategoryId,
    this.companyId,
    this.positionId,
    this.departmentId,
    this.honorImg,
    this.honorDetail,
    this.approveStatus,
    this.recordStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory HonorModel.fromJson(Map<String, dynamic> json) => HonorModel(
        id: json['id'] as int?,
        empId: json['emp_id'] as int?,
        honorCategoryId: json['honor_category_id'] as String?,
        companyId: json['company_id'] as int?,
        positionId: json['position_id'] as int?,
        departmentId: json['department_id'] as int?,
        honorImg: json['honor_img'] as String?,
        honorDetail: json['honor_detail'] as String?,
        approveStatus: json['approve_status'] as String?,
        recordStatus: json['record_status'] as String?,
        createdAt: json['created_at'] as dynamic,
        updatedAt: json['updated_at'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'emp_id': empId,
        'honor_category_id': honorCategoryId,
        'company_id': companyId,
        'position_id': positionId,
        'department_id': departmentId,
        'honor_img': honorImg,
        'honor_detail': honorDetail,
        'approve_status': approveStatus,
        'record_status': recordStatus,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
