class LeaveHistoryModel {
  int? id;
  int? empId;
  int? leaveTypeId;
  int? leaveTypeTitle;
  int? statusManagerApprove;
  int? statusHrApprove;
  String? leaveDetail;
  String? leaveImg1;
  String? leaveImg2;
  String? leaveImg3;
  String? leaveImg4;
  String? leaveImg5;
  String? leaveDateStart;
  String? leaveDateEnd;
  dynamic sumHours;
  int? day;
  int? month;
  int? year;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? leaveType;

  LeaveHistoryModel({
    this.id,
    this.empId,
    this.leaveTypeId,
    this.leaveTypeTitle,
    this.statusManagerApprove,
    this.statusHrApprove,
    this.leaveDetail,
    this.leaveImg1,
    this.leaveImg2,
    this.leaveImg3,
    this.leaveImg4,
    this.leaveImg5,
    this.leaveDateStart,
    this.leaveDateEnd,
    this.sumHours,
    this.day,
    this.month,
    this.year,
    this.createdAt,
    this.updatedAt,
    this.leaveType,
  });

  factory LeaveHistoryModel.fromJson(Map<String, dynamic> json) =>
      LeaveHistoryModel(
        id: json['id'] as int?,
        empId: json['emp_id'] as int?,
        leaveTypeId: json['leave_type_id'] as int?,
        leaveTypeTitle: json['leave_type_title'] as int?,
        statusManagerApprove: json['status_manager_approve'] as int?,
        statusHrApprove: json['status_hr__approve'] as int?,
        leaveDetail: json['leave_detail'] as String?,
        leaveImg1: json['leave_img1'] as String?,
        leaveImg2: json['leave_img2'] as String?,
        leaveImg3: json['leave_img3'] as String?,
        leaveImg4: json['leave_img4'] as String?,
        leaveImg5: json['leave_img5'] as String?,
        leaveDateStart: json['leave_date_start'] as String?,
        leaveDateEnd: json['leave_date_end'] as String?,
        sumHours: json['sum_hours'] as dynamic,
        day: json['days'] as int?,
        month: json['month'] as int?,
        year: json['year'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        leaveType: json['leave_type'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'emp_id': empId,
        'leave_type_id': leaveTypeId,
        'leave_type_title': leaveTypeTitle,
        'status_manager_approve': statusManagerApprove,
        'status_hr__approve': statusHrApprove,
        'leave_detail': leaveDetail,
        'leave_img1': leaveImg1,
        'leave_img2': leaveImg2,
        'leave_img3': leaveImg3,
        'leave_img4': leaveImg4,
        'leave_img5': leaveImg5,
        'leave_date_start': leaveDateStart,
        'leave_date_end': leaveDateEnd,
        'sum_hours': sumHours,
        'day': day,
        'month': month,
        'year': year,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'leave_type': leaveType,
      };
}
