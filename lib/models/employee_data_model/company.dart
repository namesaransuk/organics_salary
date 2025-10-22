class Company {
  int? id;
  String? nameTh;
  String? nameEn;
  String? prefix;
  String? shortName;
  String? addressTh;
  String? addressEn;
  String? contactNumber;
  String? website;
  String? email;
  dynamic code;
  int? recordStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  Company({
    this.id,
    this.nameTh,
    this.nameEn,
    this.prefix,
    this.shortName,
    this.addressTh,
    this.addressEn,
    this.contactNumber,
    this.website,
    this.email,
    this.code,
    this.recordStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json['id'] as int?,
        nameTh: json['name_th'] as String?,
        nameEn: json['name_en'] as String?,
        prefix: json['prefix'] as String?,
        shortName: json['short_name'] as String?,
        addressTh: json['address_th'] as String?,
        addressEn: json['address_en'] as String?,
        contactNumber: json['contact_number'] as String?,
        website: json['website'] as String?,
        email: json['email'] as String?,
        code: json['code'] as dynamic,
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
        'name_th': nameTh,
        'name_en': nameEn,
        'prefix': prefix,
        'short_name': shortName,
        'address_th': addressTh,
        'address_en': addressEn,
        'contact_number': contactNumber,
        'website': website,
        'email': email,
        'code': code,
        'record_status': recordStatus,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
