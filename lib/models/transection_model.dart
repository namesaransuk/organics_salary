class TransectionModel {
  int? id;
  int? empId;
  String? titleName;
  String? detail;
  int? stepStatus;
  String? sendDate;
  dynamic approveDate;
  dynamic notApproveDate;
  dynamic successDate;
  dynamic cancelDate;
  dynamic createdAt;
  dynamic updatedAt;

  TransectionModel({
    this.id,
    this.empId,
    this.titleName,
    this.detail,
    this.stepStatus,
    this.sendDate,
    this.approveDate,
    this.notApproveDate,
    this.successDate,
    this.cancelDate,
    this.createdAt,
    this.updatedAt,
  });

  factory TransectionModel.fromJson(Map<String, dynamic> json) {
    return TransectionModel(
      id: json['id'] as int?,
      empId: json['emp_id'] as int?,
      titleName: json['title_name'] as String?,
      detail: json['detail'] as String?,
      stepStatus: json['step_status'] as int?,
      sendDate: json['send_date'] as String?,
      approveDate: json['approve_date'] as dynamic,
      notApproveDate: json['not_approve_date'] as dynamic,
      successDate: json['success_date'] as dynamic,
      cancelDate: json['cancel_date'] as dynamic,
      createdAt: json['created_at'] as dynamic,
      updatedAt: json['updated_at'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'emp_id': empId,
        'title_name': titleName,
        'detail': detail,
        'step_status': stepStatus,
        'send_date': sendDate,
        'approve_date': approveDate,
        'not_approve_date': notApproveDate,
        'success_date': successDate,
        'cancel_date': cancelDate,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
