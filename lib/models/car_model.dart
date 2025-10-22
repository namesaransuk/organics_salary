class CarModel {
  int? id;
  int? empId;
  int? carCategoryId;
  String? carRegistration;
  String? carBrand;
  String? carColor;
  String? carImage;
  int? recordStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  CarModel({
    this.id,
    this.empId,
    this.carCategoryId,
    this.carRegistration,
    this.carBrand,
    this.carColor,
    this.carImage,
    this.recordStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
        id: json['id'] as int?,
        empId: json['emp_id'] as int?,
        carCategoryId: json['car_category_id'] as int?,
        carRegistration: json['car_registration'] as String?,
        carBrand: json['car_brand'] as String?,
        carColor: json['car_color'] as String?,
        carImage: json['car_image'] as String?,
        recordStatus: json['record_status'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'emp_id': empId,
        'car_category_id': carCategoryId,
        'car_registration': carRegistration,
        'car_brand': carBrand,
        'car_color': carColor,
        'car_image': carImage,
        'record_status': recordStatus,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
