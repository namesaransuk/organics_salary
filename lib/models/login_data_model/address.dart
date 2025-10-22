class Address {
  int? id;
  String? houseNo;
  String? moo;
  String? building;
  String? floor;
  String? soi;
  String? road;
  dynamic provincesId;
  dynamic amphuresId;
  dynamic tambonsId;
  int? addressType;
  int? recordStatus;
  int? empId;
  dynamic country;
  dynamic moduleId;
  dynamic moduleName;
  String? postalCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic province;
  dynamic amphures;
  dynamic tambon;

  Address({
    this.id,
    this.houseNo,
    this.moo,
    this.building,
    this.floor,
    this.soi,
    this.road,
    this.provincesId,
    this.amphuresId,
    this.tambonsId,
    this.addressType,
    this.recordStatus,
    this.empId,
    this.country,
    this.moduleId,
    this.moduleName,
    this.postalCode,
    this.createdAt,
    this.updatedAt,
    this.province,
    this.amphures,
    this.tambon,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json['id'] as int?,
        houseNo: json['house_no'] as String?,
        moo: json['moo'] as String?,
        building: json['building'] as String?,
        floor: json['floor'] as String?,
        soi: json['soi'] as String?,
        road: json['road'] as String?,
        provincesId: json['provinces_id'] as dynamic,
        amphuresId: json['amphures_id'] as dynamic,
        tambonsId: json['tambons_id'] as dynamic,
        addressType: json['address_type'] as int?,
        recordStatus: json['record_status'] as int?,
        empId: json['emp_id'] as int?,
        country: json['country'] as dynamic,
        moduleId: json['module_id'] as dynamic,
        moduleName: json['module_name'] as dynamic,
        postalCode: json['postal_code'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        province: json['province'] as dynamic,
        amphures: json['amphures'] as dynamic,
        tambon: json['tambon'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'house_no': houseNo,
        'moo': moo,
        'building': building,
        'floor': floor,
        'soi': soi,
        'road': road,
        'provinces_id': provincesId,
        'amphures_id': amphuresId,
        'tambons_id': tambonsId,
        'address_type': addressType,
        'record_status': recordStatus,
        'emp_id': empId,
        'country': country,
        'module_id': moduleId,
        'module_name': moduleName,
        'postal_code': postalCode,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'province': province,
        'amphures': amphures,
        'tambon': tambon,
      };
}
