class EmpAttendanceModel {
  int? m1;
  int? m2;
  int? m3;
  int? m4;
  int? m5;
  int? m6;
  int? m7;
  int? m8;
  int? m9;
  int? m10;
  int? m11;
  int? m12;

  EmpAttendanceModel({
    this.m1,
    this.m2,
    this.m3,
    this.m4,
    this.m5,
    this.m6,
    this.m7,
    this.m8,
    this.m9,
    this.m10,
    this.m11,
    this.m12,
  });

  factory EmpAttendanceModel.fromJson(Map<String, dynamic> json) => EmpAttendanceModel(
        m1: json['m_1'] as int?,
        m2: json['m_2'] as int?,
        m3: json['m_3'] as int?,
        m4: json['m_4'] as int?,
        m5: json['m_5'] as int?,
        m6: json['m_6'] as int?,
        m7: json['m_7'] as int?,
        m8: json['m_8'] as int?,
        m9: json['m_9'] as int?,
        m10: json['m_10'] as int?,
        m11: json['m_11'] as int?,
        m12: json['m_12'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'm_1': m1,
        'm_2': m2,
        'm_3': m3,
        'm_4': m4,
        'm_5': m5,
        'm_6': m6,
        'm_7': m7,
        'm_8': m8,
        'm_9': m9,
        'm_10': m10,
        'm_11': m11,
        'm_12': m12,
      };
}
