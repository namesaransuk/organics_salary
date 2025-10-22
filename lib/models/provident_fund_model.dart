class ProvidentFundModel {
  int? id;
  int? empId;
  String? reserveFundNumber;
  String? savingRate;
  String? day;
  String? month;
  String? year;
  int? companyId;
  int? positionId;
  int? departmentId;
  String? reserve;
  String? contribution;
  String? totalMonth;
  String? accumulateBalance;
  String? recordStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProvidentFundModel({
    this.id,
    this.empId,
    this.reserveFundNumber,
    this.savingRate,
    this.day,
    this.month,
    this.year,
    this.companyId,
    this.positionId,
    this.departmentId,
    this.reserve,
    this.contribution,
    this.totalMonth,
    this.accumulateBalance,
    this.recordStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory ProvidentFundModel.fromJson(Map<String, dynamic> json) {
    return ProvidentFundModel(
      id: json['id'] as int?,
      empId: json['emp_id'] as int?,
      reserveFundNumber: json['reserve_fund_number'] as String?,
      savingRate: json['saving_rate'] as String?,
      day: json['day'] as String?,
      month: json['month'] as String?,
      year: json['year'] as String?,
      companyId: json['company_id'] as int?,
      positionId: json['position_id'] as int?,
      departmentId: json['department_id'] as int?,
      reserve: json['reserve'] as String?,
      contribution: json['contribution'] as String?,
      totalMonth: json['total_month'] as String?,
      accumulateBalance: json['accumulate_balance'] as String?,
      recordStatus: json['record_status'] as String?,
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
        'reserve_fund_number': reserveFundNumber,
        'saving_rate': savingRate,
        'day': day,
        'month': month,
        'year': year,
        'company_id': companyId,
        'position_id': positionId,
        'department_id': departmentId,
        'reserve': reserve,
        'contribution': contribution,
        'total_month': totalMonth,
        'accumulate_balance': accumulateBalance,
        'record_status': recordStatus,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
