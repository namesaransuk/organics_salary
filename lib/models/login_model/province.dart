class Province {
  int? id;
  String? nameTh;
  String? nameEn;
  int? geographyId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Province({
    this.id,
    this.nameTh,
    this.nameEn,
    this.geographyId,
    this.createdAt,
    this.updatedAt,
  });

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        id: json['id'] as int?,
        nameTh: json['name_th'] as String?,
        nameEn: json['name_en'] as String?,
        geographyId: json['geography_id'] as int?,
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
        'geography_id': geographyId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
