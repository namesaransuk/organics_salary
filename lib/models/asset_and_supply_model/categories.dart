class Categories {
  int? id;
  String? name;
  String? description;
  String? icon;
  String? categoriesCode;
  int? layerNumber;
  dynamic hostId;
  int? categoriesOption;
  dynamic userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Categories({
    this.id,
    this.name,
    this.description,
    this.icon,
    this.categoriesCode,
    this.layerNumber,
    this.hostId,
    this.categoriesOption,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id: json['id'] as int?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        icon: json['icon'] as String?,
        categoriesCode: json['categories_code'] as String?,
        layerNumber: json['layer_number'] as int?,
        hostId: json['host_id'] as dynamic,
        categoriesOption: json['categories_option'] as int?,
        userId: json['user_id'] as dynamic,
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
        'description': description,
        'icon': icon,
        'categories_code': categoriesCode,
        'layer_number': layerNumber,
        'host_id': hostId,
        'categories_option': categoriesOption,
        'user_id': userId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
