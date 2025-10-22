import 'dart:convert';

class CoinModel {
  int? id;
  String? rewardName;
  String? rewardImage;
  String? rewardDescription;
  int? rewardCoinsChange;
  dynamic createdAt;
  dynamic updatedAt;

  CoinModel({
    this.id,
    this.rewardName,
    this.rewardImage,
    this.rewardDescription,
    this.rewardCoinsChange,
    this.createdAt,
    this.updatedAt,
  });

  factory CoinModel.fromMap(Map<String, dynamic> json) => CoinModel(
        id: json['id'] as int?,
        rewardName: json['reward_name'] as String?,
        rewardImage: json['reward_image'] as String?,
        rewardDescription: json['reward_description'] as String?,
        rewardCoinsChange: json['reward_coins_change'] as int?,
        createdAt: json['created_at'] as dynamic,
        updatedAt: json['updated_at'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'reward_name': rewardName,
        'reward_image': rewardImage,
        'reward_description': rewardDescription,
        'reward_coins_change': rewardCoinsChange,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  factory CoinModel.fromJson(String data) {
    return CoinModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
