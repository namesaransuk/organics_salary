import 'dart:convert';

class CoinModel {
  String? id;
  String? name;
  String? img;
  int? coin;

  CoinModel({this.id, this.name, this.img, this.coin});

  factory CoinModel.fromMap(Map<String, dynamic> json) => CoinModel(
        id: json['id'] as String?,
        name: json['name'] as String?,
        img: json['img'] as String?,
        coin: json['coin'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'img': img,
        'coin': coin,
      };

  factory CoinModel.fromJson(String data) {
    return CoinModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
