class EmpCompetition {
  int? id;
  String? actionsName;
  String? fileName;
  String? filePath;
  String? languageCode;
  String? fileDetail;
  dynamic note1;
  dynamic note2;
  int? moduleId;
  String? moduleName;
  int? type;
  dynamic fileUrl;
  String? userId;
  String? empId;
  int? recordStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  EmpCompetition({
    this.id,
    this.actionsName,
    this.fileName,
    this.filePath,
    this.languageCode,
    this.fileDetail,
    this.note1,
    this.note2,
    this.moduleId,
    this.moduleName,
    this.type,
    this.fileUrl,
    this.userId,
    this.empId,
    this.recordStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory EmpCompetition.fromJson(Map<String, dynamic> json) {
    return EmpCompetition(
      id: json['id'] as int?,
      actionsName: json['actions_name'] as String?,
      fileName: json['file_name'] as String?,
      filePath: json['file_path'] as String?,
      languageCode: json['language_code'] as String?,
      fileDetail: json['file_detail'] as String?,
      note1: json['note1'] as dynamic,
      note2: json['note2'] as dynamic,
      moduleId: json['module_id'] as int?,
      moduleName: json['module_name'] as String?,
      type: json['type'] as int?,
      fileUrl: json['file_url'] as dynamic,
      userId: json['user_id'] as String?,
      empId: json['emp_id'] as String?,
      recordStatus: json['record_status'] as int?,
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
        'actions_name': actionsName,
        'file_name': fileName,
        'file_path': filePath,
        'language_code': languageCode,
        'file_detail': fileDetail,
        'note1': note1,
        'note2': note2,
        'module_id': moduleId,
        'module_name': moduleName,
        'type': type,
        'file_url': fileUrl,
        'user_id': userId,
        'emp_id': empId,
        'record_status': recordStatus,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
