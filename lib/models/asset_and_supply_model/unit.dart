import 'units_name.dart';

class Unit {
  int? id;
  int? namesId;
  String? unitsCode;
  int? categoriesOption;
  dynamic userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  UnitsName? unitsName;

  Unit({
    this.id,
    this.namesId,
    this.unitsCode,
    this.categoriesOption,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.unitsName,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json['id'] as int?,
        namesId: json['names_id'] as int?,
        unitsCode: json['units_code'] as String?,
        categoriesOption: json['categories_option'] as int?,
        userId: json['user_id'] as dynamic,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        unitsName: json['units_name'] == null
            ? null
            : UnitsName.fromJson(json['units_name'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'names_id': namesId,
        'units_code': unitsCode,
        'categories_option': categoriesOption,
        'user_id': userId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'units_name': unitsName?.toJson(),
      };
}
