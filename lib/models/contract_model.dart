class ContractModel {
  int? id;
  String? contractCategoryId;
  String? empId;
  String? contractDetails;
  String? images;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? contractName;

  ContractModel({
    this.id,
    this.contractCategoryId,
    this.empId,
    this.contractDetails,
    this.images,
    this.createdAt,
    this.updatedAt,
    this.contractName,
  });

  factory ContractModel.fromJson(Map<String, dynamic> json) => ContractModel(
        id: json['id'] as int?,
        contractCategoryId: json['contract_category_id'] as String?,
        empId: json['emp_id'] as String?,
        contractDetails: json['contract_details'] as String?,
        images: json['images'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        contractName: json['contracts_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'contract_category_id': contractCategoryId,
        'emp_id': empId,
        'contract_details': contractDetails,
        'images': images,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'contracts_name': contractName,
      };
}
