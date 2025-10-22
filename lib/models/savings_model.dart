class SavingsModel {
  int? id;
  int? empId;
  int? saveStatus;
  String? amount;
  String? totalAmount;
  int? month;
  int? year;
  String? saveDate;
  int? saveChannel;
  int? approveStatus;
  dynamic remark;
  dynamic createdAt;
  dynamic updatedAt;

  SavingsModel({
    this.id,
    this.empId,
    this.saveStatus,
    this.amount,
    this.totalAmount,
    this.month,
    this.year,
    this.saveDate,
    this.saveChannel,
    this.approveStatus,
    this.remark,
    this.createdAt,
    this.updatedAt,
  });

  factory SavingsModel.fromJson(Map<String, dynamic> json) => SavingsModel(
        id: json['id'] as int?,
        empId: json['emp_id'] as int?,
        saveStatus: json['save_status'] as int?,
        amount: json['amount'] as String?,
        totalAmount: json['total_amount'] as String?,
        month: json['month'] as int?,
        year: json['year'] as int?,
        saveDate: json['save_date'] as String?,
        saveChannel: json['save_channel'] as int?,
        approveStatus: json['approve_status'] as int?,
        remark: json['remark'] as dynamic,
        createdAt: json['created_at'] as dynamic,
        updatedAt: json['updated_at'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'emp_id': empId,
        'save_status': saveStatus,
        'amount': amount,
        'total_amount': totalAmount,
        'month': month,
        'year': year,
        'save_date': saveDate,
        'save_channel': saveChannel,
        'approve_status': approveStatus,
        'remark': remark,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
