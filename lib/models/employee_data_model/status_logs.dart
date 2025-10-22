class StatusLogs {
  int? id;
  String? statusName;
  int? statusNumber;
  String? moduleName;
  String? colorClass;
  int? moduleId;
  int? empId;
  int? userId;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  StatusLogs({
    this.id,
    this.statusName,
    this.statusNumber,
    this.moduleName,
    this.colorClass,
    this.moduleId,
    this.empId,
    this.userId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory StatusLogs.fromJson(Map<String, dynamic> json) => StatusLogs(
        id: json['id'] as int?,
        statusName: json['status_name'] as String?,
        statusNumber: json['status_number'] as int?,
        moduleName: json['module_name'] as String?,
        colorClass: json['color_class'] as String?,
        moduleId: json['module_id'] as int?,
        empId: json['emp_id'] as int?,
        userId: json['user_id'] as int?,
        status: json['status'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'status_name': statusName,
        'status_number': statusNumber,
        'module_name': moduleName,
        'color_class': colorClass,
        'module_id': moduleId,
        'emp_id': empId,
        'user_id': userId,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
