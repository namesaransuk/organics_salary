class TimeHistoryModel {
  int? id;
  String? empId;
  String? pasteDate;
  String? status;
  int? year;
  int? month;
  int? days;
  dynamic imageCapture;
  DateTime? createdAt;
  DateTime? updatedAt;

  TimeHistoryModel({
    this.id,
    this.empId,
    this.pasteDate,
    this.status,
    this.year,
    this.month,
    this.days,
    this.imageCapture,
    this.createdAt,
    this.updatedAt,
  });

  factory TimeHistoryModel.fromJson(Map<String, dynamic> json) {
    return TimeHistoryModel(
      id: json['id'] as int?,
      empId: json['emp_id'] as String?,
      pasteDate: json['paste_date'] as String?,
      status: json['status'] as String?,
      year: json['year'] as int?,
      month: json['month'] as int?,
      days: json['days'] as int?,
      imageCapture: json['image_capture'] as dynamic,
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
        'paste_date': pasteDate,
        'status': status,
        'year': year,
        'month': month,
        'days': days,
        'image_capture': imageCapture,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
