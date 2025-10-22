class EmCode {
  int? id;
  String? code;
  dynamic description;
  int? itemId;
  String? itemName;
  int? categoriesOption;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  EmCode({
    this.id,
    this.code,
    this.description,
    this.itemId,
    this.itemName,
    this.categoriesOption,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory EmCode.fromJson(Map<String, dynamic> json) => EmCode(
        id: json['id'] as int?,
        code: json['code'] as String?,
        description: json['description'] as dynamic,
        itemId: json['item_id'] as int?,
        itemName: json['item_name'] as String?,
        categoriesOption: json['categories_option'] as int?,
        status: json['status'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'description': description,
        'item_id': itemId,
        'item_name': itemName,
        'categories_option': categoriesOption,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
