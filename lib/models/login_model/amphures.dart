class Amphures {
  int? id;
  String? nameTh;
  String? nameEn;
  int? provinceId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Amphures({
    this.id,
    this.nameTh,
    this.nameEn,
    this.provinceId,
    this.createdAt,
    this.updatedAt,
  });

  factory Amphures.fromJson(Map<String, dynamic> json) => Amphures(
        id: json['id'] as int?,
        nameTh: json['name_th'] as String?,
        nameEn: json['name_en'] as String?,
        provinceId: json['province_id'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name_th': nameTh,
        'name_en': nameEn,
        'province_id': provinceId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
