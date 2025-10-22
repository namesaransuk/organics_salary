class Character {
  int? id;
  String? name;
  dynamic discription;
  DateTime? createdAt;
  DateTime? updatedAt;

  Character({
    this.id,
    this.name,
    this.discription,
    this.createdAt,
    this.updatedAt,
  });

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json['id'] as int?,
        name: json['name'] as String?,
        discription: json['discription'] as dynamic,
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
        'discription': discription,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
