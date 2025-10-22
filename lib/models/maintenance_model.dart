class MaintenanceModel {
  int? empId;
  int? idReport;
  String? equipmentName;
  String? repairDetail;
  dynamic images;
  String? idCategories;
  String? categoriesName;
  int? reportStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  MaintenanceModel({
    this.empId,
    this.idReport,
    this.equipmentName,
    this.repairDetail,
    this.images,
    this.idCategories,
    this.categoriesName,
    this.reportStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory MaintenanceModel.fromJson(Map<String, dynamic> json) {
    return MaintenanceModel(
      empId: json['emp_id'] as int?,
      idReport: json['id_report'] as int?,
      equipmentName: json['equipment_name'] as String?,
      repairDetail: json['repair_detail'] as String?,
      images: json['images'] as dynamic,
      idCategories: json['id_categories'] as String?,
      categoriesName: json['categories_name'] as String?,
      reportStatus: json['report_status'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'emp_id': empId,
        'id_report': idReport,
        'equipment_name': equipmentName,
        'repair_detail': repairDetail,
        'images': images,
        'id_categories': idCategories,
        'categories_name': categoriesName,
        'report_status': reportStatus,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
