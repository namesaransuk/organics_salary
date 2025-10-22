import 'package:organics_salary/models/login_model/profile_image.dart';

import 'address.dart';
import 'company_image.dart';
import 'department.dart';
import 'fnames.dart';
import 'lnames.dart';
import 'nnames.dart';

class DataModel {
  int? id;
  int? companyId;
  int? positionId;
  int? departmentId;
  int? personalityCharacterId;
  int? fnamesId;
  int? lnamesId;
  int? nnamesId;
  String? level;
  dynamic empCard;
  String? gender;
  String? employmentType;
  String? employeeCode;
  String? prefix;
  String? birthday;
  String? phoneNumber;
  String? email;
  String? bloodGroup;
  String? idCard;
  String? startDate;
  dynamic endDate;
  dynamic username;
  String? password;
  String? statusEmp;
  dynamic remark;
  dynamic termination;
  String? pin;
  int? status;
  String? deviceKey;
  String? socialSecurityRights;
  dynamic userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? accessToken;
  String? encodeAccessToken;
  List<Address>? address;
  Fnames? fnames;
  Lnames? lnames;
  Nnames? nnames;
  CompanyImage? companyImage;
  ProfileImage? profileImage;
  Department? department;

  DataModel({
    this.id,
    this.companyId,
    this.positionId,
    this.departmentId,
    this.personalityCharacterId,
    this.fnamesId,
    this.lnamesId,
    this.nnamesId,
    this.level,
    this.empCard,
    this.gender,
    this.employmentType,
    this.employeeCode,
    this.prefix,
    this.birthday,
    this.phoneNumber,
    this.email,
    this.bloodGroup,
    this.idCard,
    this.startDate,
    this.endDate,
    this.username,
    this.password,
    this.statusEmp,
    this.remark,
    this.termination,
    this.pin,
    this.status,
    this.deviceKey,
    this.socialSecurityRights,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.accessToken,
    this.encodeAccessToken,
    this.address,
    this.fnames,
    this.lnames,
    this.nnames,
    this.companyImage,
    this.profileImage,
    this.department,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        id: json['id'] as int?,
        companyId: json['company_id'] as int?,
        positionId: json['position_id'] as int?,
        departmentId: json['department_id'] as int?,
        personalityCharacterId: json['personality_character_id'] as int?,
        fnamesId: json['fnames_id'] as int?,
        lnamesId: json['lnames_id'] as int?,
        nnamesId: json['nnames_id'] as int?,
        level: json['level'] as String?,
        empCard: json['emp_card'] as dynamic,
        gender: json['gender'] as String?,
        employmentType: json['employment_type'] as String?,
        employeeCode: json['employee_code'] as String?,
        prefix: json['prefix'] as String?,
        birthday: json['birthday'] as String?,
        phoneNumber: json['phone_number'] as String?,
        email: json['email'] as String?,
        bloodGroup: json['blood_group'] as String?,
        idCard: json['id_card'] as String?,
        startDate: json['start_date'] as String?,
        endDate: json['end_date'] as dynamic,
        username: json['username'] as dynamic,
        password: json['password'] as String?,
        statusEmp: json['status_emp'] as String?,
        remark: json['remark'] as dynamic,
        termination: json['termination'] as dynamic,
        pin: json['pin'] as String?,
        status: json['status'] as int?,
        deviceKey: json['device_key'] as String?,
        socialSecurityRights: json['social_security_rights'] as String?,
        userId: json['user_id'] as dynamic,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        accessToken: json['access_token'] as String?,
        encodeAccessToken: json['encode_access_token'] as String?,
        address: (json['address'] as List<dynamic>?)
            ?.map((e) => Address.fromJson(e as Map<String, dynamic>))
            .toList(),
        fnames: json['fnames'] == null
            ? null
            : Fnames.fromJson(json['fnames'] as Map<String, dynamic>),
        lnames: json['lnames'] == null
            ? null
            : Lnames.fromJson(json['lnames'] as Map<String, dynamic>),
        nnames: json['nnames'] == null
            ? null
            : Nnames.fromJson(json['nnames'] as Map<String, dynamic>),
        companyImage: json['company_image'] == null
            ? null
            : CompanyImage.fromJson(
                json['company_image'] as Map<String, dynamic>),
        profileImage: json['profile_image'] == null
            ? null
            : ProfileImage.fromJson(
                json['profile_image'] as Map<String, dynamic>),
        department: json['department'] == null
            ? null
            : Department.fromJson(json['department'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'company_id': companyId,
        'position_id': positionId,
        'department_id': departmentId,
        'personality_character_id': personalityCharacterId,
        'fnames_id': fnamesId,
        'lnames_id': lnamesId,
        'nnames_id': nnamesId,
        'level': level,
        'emp_card': empCard,
        'gender': gender,
        'employment_type': employmentType,
        'employee_code': employeeCode,
        'prefix': prefix,
        'birthday': birthday,
        'phone_number': phoneNumber,
        'email': email,
        'blood_group': bloodGroup,
        'id_card': idCard,
        'start_date': startDate,
        'end_date': endDate,
        'username': username,
        'password': password,
        'status_emp': statusEmp,
        'remark': remark,
        'termination': termination,
        'pin': pin,
        'status': status,
        'device_key': deviceKey,
        'social_security_rights': socialSecurityRights,
        'user_id': userId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'access_token': accessToken,
        'encode_access_token': encodeAccessToken,
        'address': address?.map((e) => e.toJson()).toList(),
        'fnames': fnames?.toJson(),
        'lnames': lnames?.toJson(),
        'nnames': nnames?.toJson(),
        'company_image': companyImage?.toJson(),
        'profile_image': profileImage?.toJson(),
        'department': department?.toJson(),
      };
}
