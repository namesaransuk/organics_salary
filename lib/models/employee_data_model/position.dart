import 'position_text.dart';
import 'welfare.dart';

class Position {
  int? id;
  int? namesId;
  dynamic companyId;
  int? level;
  int? recordStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Welfare>? welfare;
  PositionText? positionText;

  Position({
    this.id,
    this.namesId,
    this.companyId,
    this.level,
    this.recordStatus,
    this.createdAt,
    this.updatedAt,
    this.welfare,
    this.positionText,
  });

  factory Position.fromJson(Map<String, dynamic> json) => Position(
        id: json['id'] as int?,
        namesId: json['names_id'] as int?,
        companyId: json['company_id'] as dynamic,
        level: json['level'] as int?,
        recordStatus: json['record_status'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        welfare: (json['welfare'] as List<dynamic>?)
            ?.map((e) => Welfare.fromJson(e as Map<String, dynamic>))
            .toList(),
        positionText: json['position_text'] == null
            ? null
            : PositionText.fromJson(
                json['position_text'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'names_id': namesId,
        'company_id': companyId,
        'level': level,
        'record_status': recordStatus,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'welfare': welfare?.map((e) => e.toJson()).toList(),
        'position_text': positionText?.toJson(),
      };
}
