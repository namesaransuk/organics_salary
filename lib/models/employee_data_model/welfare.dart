class Welfare {
  int? id;
  String? name;
  int? level;
  int? recordStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  Welfare({
    this.id,
    this.name,
    this.level,
    this.recordStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory Welfare.fromJson(Map<String, dynamic> json) => Welfare(
        id: json['id'] as int?,
        name: json['name'] as String?,
        level: json['level'] as int?,
        recordStatus: json['record_status'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'level': level,
        'record_status': recordStatus,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
