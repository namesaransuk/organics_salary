import 'multitext.dart';
import 'singletexts.dart';

class DepartmentText {
  int? id;
  dynamic usersId;
  String? moduleNote;
  DateTime? createdAt;
  DateTime? updatedAt;
  Singletexts? singletexts;
  List<Multitext>? multitexts;

  DepartmentText({
    this.id,
    this.usersId,
    this.moduleNote,
    this.createdAt,
    this.updatedAt,
    this.singletexts,
    this.multitexts,
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
      multitexts: (json['multitexts'] as List<dynamic>?)
          ?.map((e) => Multitext.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'users_id': usersId,
        'module_note': moduleNote,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'singletexts': singletexts?.toJson(),
        'multitexts': multitexts?.map((e) => e.toJson()).toList(),
      };
}
