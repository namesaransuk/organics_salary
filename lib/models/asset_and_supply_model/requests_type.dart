import 'categories.dart';
import 'em_code.dart';
import 'equipment_image.dart';
import 'unit.dart';

class RequestsType {
  int? id;
  String? name;
  int? unitsId;
  int? asCategoriesId;
  dynamic asTypeCategoriesId;
  dynamic asKindCategoriesId;
  dynamic locationsId;
  dynamic empId;
  dynamic departmentId;
  int? companyId;
  dynamic serialNumber;
  dynamic model;
  dynamic brand;
  String? description;
  dynamic dateAdmission;
  dynamic datePurchase;
  int? minimumAlert;
  int? maximumAlert;
  dynamic statusProperty;
  dynamic costPrice;
  int? limitYear;
  String? salvagePrice;
  dynamic imgAssetId;
  int? userId;
  int? typeAsset;
  int? categoriesOption;
  DateTime? createdAt;
  DateTime? updatedAt;
  Categories? categories;
  dynamic assetType;
  dynamic assetClass;
  Unit? unit;
  dynamic assetImage;
  EquipmentImage? equipmentImage;
  EmCode? emCode;

  RequestsType({
    this.id,
    this.name,
    this.unitsId,
    this.asCategoriesId,
    this.asTypeCategoriesId,
    this.asKindCategoriesId,
    this.locationsId,
    this.empId,
    this.departmentId,
    this.companyId,
    this.serialNumber,
    this.model,
    this.brand,
    this.description,
    this.dateAdmission,
    this.datePurchase,
    this.minimumAlert,
    this.maximumAlert,
    this.statusProperty,
    this.costPrice,
    this.limitYear,
    this.salvagePrice,
    this.imgAssetId,
    this.userId,
    this.typeAsset,
    this.categoriesOption,
    this.createdAt,
    this.updatedAt,
    this.categories,
    this.assetType,
    this.assetClass,
    this.unit,
    this.assetImage,
    this.equipmentImage,
    this.emCode,
  });

  factory RequestsType.fromJson(Map<String, dynamic> json) => RequestsType(
        id: json['id'] as int?,
        name: json['name'] as String?,
        unitsId: json['units_id'] as int?,
        asCategoriesId: json['as_categories_id'] as int?,
        asTypeCategoriesId: json['as_type_categories_id'] as dynamic,
        asKindCategoriesId: json['as_kind_categories_id'] as dynamic,
        locationsId: json['locations_id'] as dynamic,
        empId: json['emp_id'] as dynamic,
        departmentId: json['department_id'] as dynamic,
        companyId: json['company_id'] as int?,
        serialNumber: json['serial_number'] as dynamic,
        model: json['model'] as dynamic,
        brand: json['brand'] as dynamic,
        description: json['description'] as String?,
        dateAdmission: json['date_admission'] as dynamic,
        datePurchase: json['date_purchase'] as dynamic,
        minimumAlert: json['minimum_alert'] as int?,
        maximumAlert: json['maximum_alert'] as int?,
        statusProperty: json['status_property'] as dynamic,
        costPrice: json['cost_price'] as dynamic,
        limitYear: json['limit_year'] as int?,
        salvagePrice: json['salvage_price'] as String?,
        imgAssetId: json['img_asset_id'] as dynamic,
        userId: json['user_id'] as int?,
        typeAsset: json['type_asset'] as int?,
        categoriesOption: json['categories_option'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        categories: json['categories'] == null
            ? null
            : Categories.fromJson(json['categories'] as Map<String, dynamic>),
        assetType: json['asset_type'] as dynamic,
        assetClass: json['asset_class'] as dynamic,
        unit: json['unit'] == null
            ? null
            : Unit.fromJson(json['unit'] as Map<String, dynamic>),
        assetImage: json['asset_image'] as dynamic,
        equipmentImage: json['equipment_image'] == null
            ? null
            : EquipmentImage.fromJson(
                json['equipment_image'] as Map<String, dynamic>),
        emCode: json['em_code'] == null
            ? null
            : EmCode.fromJson(json['em_code'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'units_id': unitsId,
        'as_categories_id': asCategoriesId,
        'as_type_categories_id': asTypeCategoriesId,
        'as_kind_categories_id': asKindCategoriesId,
        'locations_id': locationsId,
        'emp_id': empId,
        'department_id': departmentId,
        'company_id': companyId,
        'serial_number': serialNumber,
        'model': model,
        'brand': brand,
        'description': description,
        'date_admission': dateAdmission,
        'date_purchase': datePurchase,
        'minimum_alert': minimumAlert,
        'maximum_alert': maximumAlert,
        'status_property': statusProperty,
        'cost_price': costPrice,
        'limit_year': limitYear,
        'salvage_price': salvagePrice,
        'img_asset_id': imgAssetId,
        'user_id': userId,
        'type_asset': typeAsset,
        'categories_option': categoriesOption,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'categories': categories?.toJson(),
        'asset_type': assetType,
        'asset_class': assetClass,
        'unit': unit?.toJson(),
        'asset_image': assetImage,
        'equipment_image': equipmentImage?.toJson(),
        'em_code': emCode?.toJson(),
      };
}
