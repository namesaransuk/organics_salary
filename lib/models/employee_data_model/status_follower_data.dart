class StatusFollowerData {
  List<dynamic>? menuAction;
  List<dynamic>? radioList;
  List<dynamic>? buttonAction;
  List<dynamic>? curentStatus;

  StatusFollowerData({
    this.menuAction,
    this.radioList,
    this.buttonAction,
    this.curentStatus,
  });

  factory StatusFollowerData.fromJson(Map<String, dynamic> json) {
    return StatusFollowerData(
      menuAction: json['menu_action'] as List<dynamic>?,
      radioList: json['radio_list'] as List<dynamic>?,
      buttonAction: json['button_action'] as List<dynamic>?,
      curentStatus: json['curent_status'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toJson() => {
        'menu_action': menuAction,
        'radio_list': radioList,
        'button_action': buttonAction,
        'curent_status': curentStatus,
      };
}
