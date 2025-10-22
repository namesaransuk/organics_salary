import 'button_action.dart';
import 'curent_status.dart';
import 'radio_list.dart';

class StatusRoute {
  List<dynamic>? menuAction;
  List<RadioList>? radioList;
  ButtonAction? buttonAction;
  CurentStatus? curentStatus;

  StatusRoute({
    this.menuAction,
    this.radioList,
    this.buttonAction,
    this.curentStatus,
  });

  factory StatusRoute.fromJson(Map<String, dynamic> json) => StatusRoute(
        menuAction: json['menu_action'] as List<dynamic>?,
        radioList: (json['radio_list'] as List<dynamic>?)
            ?.map((e) => RadioList.fromJson(e as Map<String, dynamic>))
            .toList(),
        buttonAction: json['button_action'] == null
            ? null
            : ButtonAction.fromJson(
                json['button_action'] as Map<String, dynamic>),
        curentStatus: json['curent_status'] == null
            ? null
            : CurentStatus.fromJson(
                json['curent_status'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'menu_action': menuAction,
        'radio_list': radioList?.map((e) => e.toJson()).toList(),
        'button_action': buttonAction?.toJson(),
        'curent_status': curentStatus?.toJson(),
      };
}
