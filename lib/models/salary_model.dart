class SalaryModel {
  int? id;
  int? empId;
  int? salary;
  int? diligenceAllowance;
  int? overtime;
  int? fuelCost;
  int? bonus;
  int? interest;
  int? commission;
  int? getOrthers;
  int? totalEarning;
  int? socialSecurityFund;
  int? withholdingTax;
  int? deposit;
  int? absentLeaveLate;
  int? companyLoan;
  int? depositFund;
  int? deducOthers;
  int? totalDeductions;
  int? netPay;
  int? day;
  int? month;
  int? year;
  dynamic createdAt;
  dynamic updatedAt;

  SalaryModel({
    this.id,
    this.empId,
    this.salary,
    this.diligenceAllowance,
    this.overtime,
    this.fuelCost,
    this.bonus,
    this.interest,
    this.commission,
    this.getOrthers,
    this.totalEarning,
    this.socialSecurityFund,
    this.withholdingTax,
    this.deposit,
    this.absentLeaveLate,
    this.companyLoan,
    this.depositFund,
    this.deducOthers,
    this.totalDeductions,
    this.netPay,
    this.day,
    this.month,
    this.year,
    this.createdAt,
    this.updatedAt,
  });

  factory SalaryModel.fromJson(Map<String, dynamic> json) => SalaryModel(
        id: json['id'] as int?,
        empId: json['emp_id'] as int?,
        salary: json['salary'] as int?,
        diligenceAllowance: json['diligence_allowance'] as int?,
        overtime: json['overtime'] as int?,
        fuelCost: json['fuel_cost'] as int?,
        bonus: json['bonus'] as int?,
        interest: json['interest'] as int?,
        commission: json['commission'] as int?,
        getOrthers: json['get_orthers'] as int?,
        totalEarning: json['total_earning'] as int?,
        socialSecurityFund: json['social_security_fund'] as int?,
        withholdingTax: json['withholding_tax'] as int?,
        deposit: json['deposit'] as int?,
        absentLeaveLate: json['absent_leave_late'] as int?,
        companyLoan: json['company_loan'] as int?,
        depositFund: json['deposit_fund'] as int?,
        deducOthers: json['deduc_others'] as int?,
        totalDeductions: json['total_deductions'] as int?,
        netPay: json['net_pay'] as int?,
        day: json['day'] as int?,
        month: json['month'] as int?,
        year: json['year'] as int?,
        createdAt: json['created_at'] as dynamic,
        updatedAt: json['updated_at'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'emp_id': empId,
        'salary': salary,
        'diligence_allowance': diligenceAllowance,
        'overtime': overtime,
        'fuel_cost': fuelCost,
        'bonus': bonus,
        'interest': interest,
        'commission': commission,
        'get_orthers': getOrthers,
        'total_earning': totalEarning,
        'social_security_fund': socialSecurityFund,
        'withholding_tax': withholdingTax,
        'deposit': deposit,
        'absent_leave_late': absentLeaveLate,
        'company_loan': companyLoan,
        'deposit_fund': depositFund,
        'deduc_others': deducOthers,
        'total_deductions': totalDeductions,
        'net_pay': netPay,
        'day': day,
        'month': month,
        'year': year,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
