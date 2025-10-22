class Multitext {
  int? id;
  int? importedNamesHeadsId;
  String? name;
  dynamic usersId;
  int? empId;
  String? languageCode;
  DateTime? createdAt;
  DateTime? updatedAt;

  Multitext({
    this.id,
    this.importedNamesHeadsId,
    this.name,
    this.usersId,
    this.empId,
    this.languageCode,
    this.createdAt,
    this.updatedAt,
  });

  factory Multitext.fromJson(Map<String, dynamic> json) => Multitext(
        id: json['id'] as int?,
        importedNamesHeadsId: json['imported_names_heads_id'] as int?,
        name: json['name'] as String?,
        usersId: json['users_id'] as dynamic,
        empId: json['emp_id'] as int?,
        languageCode: json['language_code'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'imported_names_heads_id': importedNamesHeadsId,
        'name': name,
        'users_id': usersId,
        'emp_id': empId,
        'language_code': languageCode,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
