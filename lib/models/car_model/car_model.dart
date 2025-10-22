import 'datum.dart';

class CarModel {
  List<Datum>? data;

  CarModel({this.data});

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
