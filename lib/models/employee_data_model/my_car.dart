import 'car_image.dart';

class MyCar {
  int? id;
  int? empId;
  dynamic companyId;
  dynamic departmentId;
  int? carCategoryId;
  String? carRegistration;
  String? carBrand;
  String? carColor;
  int? transactionRequestsId;
  int? recordStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  CarImage? carImage;

  MyCar({
    this.id,
    this.empId,
    this.companyId,
    this.departmentId,
    this.carCategoryId,
    this.carRegistration,
    this.carBrand,
    this.carColor,
    this.transactionRequestsId,
    this.recordStatus,
    this.createdAt,
    this.updatedAt,
    this.carImage,
  });

  factory MyCar.fromJson(Map<String, dynamic> json) => MyCar(
        id: json['id'] as int?,
        empId: json['emp_id'] as int?,
        companyId: json['company_id'] as dynamic,
        departmentId: json['department_id'] as dynamic,
        carCategoryId: json['car_category_id'] as int?,
        carRegistration: json['car_registration'] as String?,
        carBrand: json['car_brand'] as String?,
        carColor: json['car_color'] as String?,
        transactionRequestsId: json['transaction_requests_id'] as int?,
        recordStatus: json['record_status'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        carImage: json['car_image'] == null
            ? null
            : CarImage.fromJson(json['car_image'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'emp_id': empId,
        'company_id': companyId,
        'department_id': departmentId,
        'car_category_id': carCategoryId,
        'car_registration': carRegistration,
        'car_brand': carBrand,
        'car_color': carColor,
        'transaction_requests_id': transactionRequestsId,
        'record_status': recordStatus,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'car_image': carImage?.toJson(),
      };
}
