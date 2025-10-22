class CoinHistoryModel {
  int? id;
  int? empId;
  int? typeReward;
  String? rewardName;
  String? rewardImage;
  int? rewardCoinsChange;
  int? recordStatus;
  DateTime? createdAt;
  String? approveAt;
  String? notApprovedAt;
  String? cancelAt;
  DateTime? updatedAt;

  CoinHistoryModel({
    this.id,
    this.empId,
    this.typeReward,
    this.rewardName,
    this.rewardImage,
    this.rewardCoinsChange,
    this.recordStatus,
    this.createdAt,
    this.approveAt,
    this.notApprovedAt,
    this.cancelAt,
    this.updatedAt,
  });

  factory CoinHistoryModel.fromJson(Map<String, dynamic> json) {
    return CoinHistoryModel(
      id: json['id'] as int?,
      empId: json['emp_id'] as int?,
      typeReward: json['type_reward'] as int?,
      rewardName: json['reward_name'] as String?,
      rewardImage: json['reward_image'] as String?,
      rewardCoinsChange: json['reward_coins_change'] as int?,
      recordStatus: json['record_status'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      approveAt: json['approve_at'] as String?,
      notApprovedAt: json['not_approved_at'] as String?,
      cancelAt: json['cancel_at'] as String?,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'emp_id': empId,
        'type_reward': typeReward,
        'reward_name': rewardName,
        'reward_image': rewardImage,
        'reward_coins_change': rewardCoinsChange,
        'record_status': recordStatus,
        'created_at': createdAt?.toIso8601String(),
        'approve_at': approveAt,
        'not_approved_at': notApprovedAt,
        'cancel_at': cancelAt,
        'updated_at': updatedAt?.toIso8601String(),
      };
}
