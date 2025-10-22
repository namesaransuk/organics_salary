import 'multitext.dart';

class Fnames {
  int? id;
  dynamic usersId;
  String? moduleNote;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Multitext>? multitexts;

  Fnames({
    this.id,
    this.usersId,
    this.moduleNote,
    this.createdAt,
    this.updatedAt,
    this.multitexts,
  });

  factory Fnames.fromJson(Map<String, dynamic> json) => Fnames(
        id: json['id'] as int?,
        usersId: json['users_id'] as dynamic,
        moduleNote: json['module_note'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        multitexts: (json['multitexts'] as List<dynamic>?)
            ?.map((e) => Multitext.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'users_id': usersId,
        'module_note': moduleNote,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'multitexts': multitexts?.map((e) => e.toJson()).toList(),
      };
}
