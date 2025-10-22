class NewsModel {
  int? id;
  String? announcementTopic;
  String? announcementContent;
  String? newsImg1;
  String? newsImg2;
  String? newsImg3;
  int? categoryId;
  String? category;
  String? addDate;
  String? startDate;
  String? endDate;
  String? announcerName;
  int? recordStatus;

  NewsModel({
    this.id,
    this.announcementTopic,
    this.announcementContent,
    this.newsImg1,
    this.newsImg2,
    this.newsImg3,
    this.categoryId,
    this.category,
    this.addDate,
    this.startDate,
    this.endDate,
    this.announcerName,
    this.recordStatus,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        id: json['id'] as int?,
        announcementTopic: json['announcement_topic'] as String?,
        announcementContent: json['announcement_content'] as String?,
        newsImg1: json['news_img1'] as String?,
        newsImg2: json['news_img2'] as String?,
        newsImg3: json['news_img3'] as String?,
        categoryId: json['category_id'] as int?,
        category: json['category'] as String?,
        addDate: json['add_date'] as String?,
        startDate: json['start_date'] as String?,
        endDate: json['end_date'] as String?,
        announcerName: json['announcer_name'] as String?,
        recordStatus: json['record_status'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'announcement_topic': announcementTopic,
        'announcement_content': announcementContent,
        'news_img1': newsImg1,
        'news_img2': newsImg2,
        'news_img3': newsImg3,
        'category_id': categoryId,
        'category': category,
        'add_date': addDate,
        'start_date': startDate,
        'end_date': endDate,
        'announcer_name': announcerName,
        'record_status': recordStatus,
      };
}
