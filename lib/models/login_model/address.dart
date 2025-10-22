import 'amphures.dart';
import 'province.dart';
import 'tambon.dart';

class Address {
  int? id;
  String? houseNo;
  String? moo;
  String? building;
  String? floor;
  String? soi;
  String? road;
  int? provincesId;
  int? amphuresId;
  int? tambonsId;
  int? addressType;
  int? recordStatus;
  int? empId;
  String? country;
  String? postalCode;
  dynamic createdAt;
  dynamic updatedAt;
  Province? province;
  Amphures? amphures;
  Tambon? tambon;

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
        provincesId: json['provinces_id'] as int?,
        amphuresId: json['amphures_id'] as int?,
        tambonsId: json['tambons_id'] as int?,
        addressType: json['address_type'] as int?,
        recordStatus: json['record_status'] as int?,
        empId: json['emp_id'] as int?,
        country: json['country'] as String?,
        postalCode: json['postal_code'] as String?,
        createdAt: json['created_at'] as dynamic,
        updatedAt: json['updated_at'] as dynamic,
        province: json['province'] == null
            ? null
            : Province.fromJson(json['province'] as Map<String, dynamic>),
        amphures: json['amphures'] == null
            ? null
            : Amphures.fromJson(json['amphures'] as Map<String, dynamic>),
        tambon: json['tambon'] == null
            ? null
            : Tambon.fromJson(json['tambon'] as Map<String, dynamic>),
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
        'postal_code': postalCode,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'province': province?.toJson(),
        'amphures': amphures?.toJson(),
        'tambon': tambon?.toJson(),
      };
}
