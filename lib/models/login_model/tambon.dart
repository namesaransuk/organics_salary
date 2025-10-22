class Tambon {
  int? id;
  int? zipCode;
  String? nameTh;
  String? nameEn;
  int? amphureId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Tambon({
    this.id,
    this.zipCode,
    this.nameTh,
    this.nameEn,
    this.amphureId,
    this.createdAt,
    this.updatedAt,
  });

  factory Tambon.fromJson(Map<String, dynamic> json) => Tambon(
        id: json['id'] as int?,
        zipCode: json['zip_code'] as int?,
        nameTh: json['name_th'] as String?,
        nameEn: json['name_en'] as String?,
        amphureId: json['amphure_id'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'zip_code': zipCode,
        'name_th': nameTh,
        'name_en': nameEn,
        'amphure_id': amphureId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
