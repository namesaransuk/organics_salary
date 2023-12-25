class SalaryModel {
  String? name;
  String? customer;
  String? role;
  String? salaryMonth;
  String? yearValue;
  int? salary;
  int? da;
  int? ot;
  int? fc;
  int? bonus;
  int? interest;
  int? pm;
  int? oi;
  int? ti;
  int? ss;
  int? tax;
  int? dp;
  int? agl;
  int? loan;
  int? df;
  int? od;
  int? td;
  int? total;

  SalaryModel({
    this.name,
    this.customer,
    this.role,
    this.salaryMonth,
    this.yearValue,
    this.salary,
    this.da,
    this.ot,
    this.fc,
    this.bonus,
    this.interest,
    this.pm,
    this.oi,
    this.ti,
    this.ss,
    this.tax,
    this.dp,
    this.agl,
    this.loan,
    this.df,
    this.od,
    this.td,
    this.total,
  });

  factory SalaryModel.fromJson(Map<String, dynamic> json) => SalaryModel(
        name: json['name'] as String?,
        customer: json['customer'] as String?,
        role: json['role'] as String?,
        salaryMonth: json['salaryMonth'] as String?,
        yearValue: json['yearValue'] as String?,
        salary: json['salary'] as int?,
        da: json['da'] as int?,
        ot: json['ot'] as int?,
        fc: json['fc'] as int?,
        bonus: json['bonus'] as int?,
        interest: json['interest'] as int?,
        pm: json['pm'] as int?,
        oi: json['oi'] as int?,
        ti: json['ti'] as int?,
        ss: json['ss'] as int?,
        tax: json['tax'] as int?,
        dp: json['dp'] as int?,
        agl: json['agl'] as int?,
        loan: json['loan'] as int?,
        df: json['df'] as int?,
        od: json['od'] as int?,
        td: json['td'] as int?,
        total: json['total'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'customer': customer,
        'role': role,
        'salaryMonth': salaryMonth,
        'yearValue': yearValue,
        'salary': salary,
        'da': da,
        'ot': ot,
        'fc': fc,
        'bonus': bonus,
        'interest': interest,
        'pm': pm,
        'oi': oi,
        'ti': ti,
        'ss': ss,
        'tax': tax,
        'dp': dp,
        'agl': agl,
        'loan': loan,
        'df': df,
        'od': od,
        'td': td,
        'total': total,
      };
}
