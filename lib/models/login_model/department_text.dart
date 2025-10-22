import 'singletexts.dart';

class DepartmentText {
  int? id;
  dynamic usersId;
  String? moduleNote;
  DateTime? createdAt;
  DateTime? updatedAt;
  Singletexts? singletexts;

  DepartmentText({
    this.id,
    this.usersId,
    this.moduleNote,
    this.createdAt,
    this.updatedAt,
    this.singletexts,
  });

  factory DepartmentText.fromJson(Map<String, dynamic> json) {
    return DepartmentText(
      id: json['id'] as int?,
      usersId: json['users_id'] as dynamic,
      moduleNote: json['module_note'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      singletexts: json['singletexts'] == null
          ? null
          : Singletexts.fromJson(json['singletexts'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'users_id': usersId,
        'module_note': moduleNote,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'singletexts': singletexts?.toJson(),
      };
}
