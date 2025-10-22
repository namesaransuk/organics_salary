class CurentStatus {
  int? statusNumber;
  String? textAssigner;
  String? textRadio;
  String? textButton;
  String? textFollower;
  String? empStatusApp;
  String? empStatusColorApp;
  String? statusName;
  String? colorClass;
  int? type;
  String? icon;

  CurentStatus({
    this.statusNumber,
    this.textAssigner,
    this.textRadio,
    this.textButton,
    this.textFollower,
    this.empStatusApp,
    this.empStatusColorApp,
    this.statusName,
    this.colorClass,
    this.type,
    this.icon,
  });

  factory CurentStatus.fromJson(Map<String, dynamic> json) => CurentStatus(
        statusNumber: json['status_number'] as int?,
        textAssigner: json['text_assigner'] as String?,
        textRadio: json['text_radio'] as String?,
        textButton: json['text_button'] as String?,
        textFollower: json['text_follower'] as String?,
        empStatusApp: json['emp_status_app'] as String?,
        empStatusColorApp: json['emp_status_color_app'] as String?,
        statusName: json['status_name'] as String?,
        colorClass: json['color_class'] as String?,
        type: json['type'] as int?,
        icon: json['icon'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'status_number': statusNumber,
        'text_assigner': textAssigner,
        'text_radio': textRadio,
        'text_button': textButton,
        'text_follower': textFollower,
        'emp_status_app': empStatusApp,
        'emp_status_color_app': empStatusColorApp,
        'status_name': statusName,
        'color_class': colorClass,
        'type': type,
        'icon': icon,
      };
}
