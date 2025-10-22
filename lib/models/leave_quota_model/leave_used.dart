class LeaveUsed {
  int? days;
  int? hours;
  int? minutes;

  LeaveUsed({this.days, this.hours, this.minutes});

  factory LeaveUsed.fromJson(Map<String, dynamic> json) => LeaveUsed(
        days: json['days'] as int?,
        hours: json['hours'] as int?,
        minutes: json['minutes'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'days': days,
        'hours': hours,
        'minutes': minutes,
      };
}
