class NotificationModel {
  int? id;
  int? newsNoticeId;
  int? empId;
  int? categoryId;
  String? category;
  String? newsNoticeName;
  String? newsNoticeDescription;
  int? newsPriority;
  int? readOrNot;
  int? recordStatus;
  String? createdAt;
  String? updatedAt;

  NotificationModel({
    this.id,
    this.newsNoticeId,
    this.empId,
    this.categoryId,
    this.category,
    this.newsNoticeName,
    this.newsNoticeDescription,
    this.newsPriority,
    this.readOrNot,
    this.recordStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int?,
      newsNoticeId: json['news_notice_id'] as int?,
      empId: json['emp_id'] as int?,
      categoryId: json['category_id'] as int?,
      category: json['category'] as String?,
      newsNoticeName: json['news_notice_name'] as String?,
      newsNoticeDescription: json['news_notice_description'] as String?,
      newsPriority: json['news_priority'] as int?,
      readOrNot: json['read_or_not'] as int?,
      recordStatus: json['record_status'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'news_notice_id': newsNoticeId,
        'category_id': categoryId,
        'category': category,
        'news_notice_name': newsNoticeName,
        'news_notice_description': newsNoticeDescription,
        'news_priority': newsPriority,
        'read_or_not': readOrNot,
        'record_status': recordStatus,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
