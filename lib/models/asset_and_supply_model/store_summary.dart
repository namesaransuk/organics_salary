class StoreSummary {
  int? itemId;
  String? storeName;
  String? name;
  dynamic model;
  dynamic brand;
  int? categoriesOption;
  int? typeAsset;
  int? asCategoriesId;
  dynamic asTypeCategoriesId;
  dynamic asKindCategoriesId;
  int? minimumAlert;
  int? maximumAlert;
  int? companyId;
  dynamic empId;
  int? storeId;
  String? amountItem;

  StoreSummary({
    this.itemId,
    this.storeName,
    this.name,
    this.model,
    this.brand,
    this.categoriesOption,
    this.typeAsset,
    this.asCategoriesId,
    this.asTypeCategoriesId,
    this.asKindCategoriesId,
    this.minimumAlert,
    this.maximumAlert,
    this.companyId,
    this.empId,
    this.storeId,
    this.amountItem,
  });

  factory StoreSummary.fromJson(Map<String, dynamic> json) => StoreSummary(
        itemId: json['item_id'] as int?,
        storeName: json['STORE_NAME'] as String?,
        name: json['name'] as String?,
        model: json['model'] as dynamic,
        brand: json['brand'] as dynamic,
        categoriesOption: json['categories_option'] as int?,
        typeAsset: json['type_asset'] as int?,
        asCategoriesId: json['as_categories_id'] as int?,
        asTypeCategoriesId: json['as_type_categories_id'] as dynamic,
        asKindCategoriesId: json['as_kind_categories_id'] as dynamic,
        minimumAlert: json['minimum_alert'] as int?,
        maximumAlert: json['maximum_alert'] as int?,
        companyId: json['company_id'] as int?,
        empId: json['emp_id'] as dynamic,
        storeId: json['store_id'] as int?,
        amountItem: json['amount_item'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'item_id': itemId,
        'STORE_NAME': storeName,
        'name': name,
        'model': model,
        'brand': brand,
        'categories_option': categoriesOption,
        'type_asset': typeAsset,
        'as_categories_id': asCategoriesId,
        'as_type_categories_id': asTypeCategoriesId,
        'as_kind_categories_id': asKindCategoriesId,
        'minimum_alert': minimumAlert,
        'maximum_alert': maximumAlert,
        'company_id': companyId,
        'emp_id': empId,
        'store_id': storeId,
        'amount_item': amountItem,
      };
}
