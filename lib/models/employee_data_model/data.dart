import 'certificate_file_one.dart';
import 'certificate_file_two.dart';
import 'character.dart';
import 'company.dart';
import 'department.dart';
import 'emp_book_bank.dart';
import 'fnames.dart';
import 'lnames.dart';
import 'my_car.dart';
import 'nnames.dart';
import 'position.dart';
import 'social_security.dart';

class Data {
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
  List<SocialSecurity>? socialSecurity;
  List<dynamic>? address;
  Fnames? fnames;
  Lnames? lnames;
  Nnames? nnames;
  dynamic profileImage;
  List<dynamic>? abilityImage;
  List<dynamic>? licenseImage;
  List<dynamic>? trainingImage;
  List<CertificateFileOne>? certificateFileOne;
  List<CertificateFileTwo>? certificateFileTwo;
  dynamic bank;
  List<dynamic>? emergency;
  List<dynamic>? education;
  List<dynamic>? workExperience;
  Department? department;
  Position? position;
  Character? character;
  dynamic salary;
  List<dynamic>? skill;
  dynamic benefit;
  MyCar? myCar;
  Company? company;
  dynamic groupInsurance;
  List<dynamic>? empUrlAllContract;
  List<dynamic>? empContract;
  List<dynamic>? empConfidentiality;
  List<dynamic>? empCompetition;
  List<dynamic>? empPaidTraining;
  List<dynamic>? empAssetLoan;
  List<dynamic>? empSavingContract;
  List<dynamic>? empUrlAllRegistration;
  List<dynamic>? empForm;
  List<dynamic>? empIdCard;
  List<dynamic>? empHouse;
  List<dynamic>? empEducational;
  List<EmpBookBank>? empBookBank;

  Data({
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
    this.socialSecurity,
    this.address,
    this.fnames,
    this.lnames,
    this.nnames,
    this.profileImage,
    this.abilityImage,
    this.licenseImage,
    this.trainingImage,
    this.certificateFileOne,
    this.certificateFileTwo,
    this.bank,
    this.emergency,
    this.education,
    this.workExperience,
    this.department,
    this.position,
    this.character,
    this.salary,
    this.skill,
    this.benefit,
    this.myCar,
    this.company,
    this.groupInsurance,
    this.empUrlAllContract,
    this.empContract,
    this.empConfidentiality,
    this.empCompetition,
    this.empPaidTraining,
    this.empAssetLoan,
    this.empSavingContract,
    this.empUrlAllRegistration,
    this.empForm,
    this.empIdCard,
    this.empHouse,
    this.empEducational,
    this.empBookBank,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        socialSecurity: (json['social_security'] as List<dynamic>?)
            ?.map((e) => SocialSecurity.fromJson(e as Map<String, dynamic>))
            .toList(),
        address: json['address'] as List<dynamic>?,
        fnames: json['fnames'] == null
            ? null
            : Fnames.fromJson(json['fnames'] as Map<String, dynamic>),
        lnames: json['lnames'] == null
            ? null
            : Lnames.fromJson(json['lnames'] as Map<String, dynamic>),
        nnames: json['nnames'] == null
            ? null
            : Nnames.fromJson(json['nnames'] as Map<String, dynamic>),
        profileImage: json['profile_image'] as dynamic,
        abilityImage: json['ability_image'] as List<dynamic>?,
        licenseImage: json['license_image'] as List<dynamic>?,
        trainingImage: json['training_image'] as List<dynamic>?,
        certificateFileOne: (json['certificate_file_one'] as List<dynamic>?)
            ?.map((e) => CertificateFileOne.fromJson(e as Map<String, dynamic>))
            .toList(),
        certificateFileTwo: (json['certificate_file_two'] as List<dynamic>?)
            ?.map((e) => CertificateFileTwo.fromJson(e as Map<String, dynamic>))
            .toList(),
        bank: json['bank'] as dynamic,
        emergency: json['emergency'] as List<dynamic>?,
        education: json['education'] as List<dynamic>?,
        workExperience: json['work_experience'] as List<dynamic>?,
        department: json['department'] == null
            ? null
            : Department.fromJson(json['department'] as Map<String, dynamic>),
        position: json['position'] == null
            ? null
            : Position.fromJson(json['position'] as Map<String, dynamic>),
        character: json['character'] == null
            ? null
            : Character.fromJson(json['character'] as Map<String, dynamic>),
        salary: json['salary'] as dynamic,
        skill: json['skill'] as List<dynamic>?,
        benefit: json['benefit'] as dynamic,
        myCar: json['my_car'] == null
            ? null
            : MyCar.fromJson(json['my_car'] as Map<String, dynamic>),
        company: json['company'] == null
            ? null
            : Company.fromJson(json['company'] as Map<String, dynamic>),
        groupInsurance: json['group_insurance'] as dynamic,
        empUrlAllContract: json['emp_url_all_contract'] as List<dynamic>?,
        empContract: json['emp_contract'] as List<dynamic>?,
        empConfidentiality: json['emp_confidentiality'] as List<dynamic>?,
        empCompetition: json['emp_competition'] as List<dynamic>?,
        empPaidTraining: json['emp_paid_training'] as List<dynamic>?,
        empAssetLoan: json['emp_asset_loan'] as List<dynamic>?,
        empSavingContract: json['emp_saving_contract'] as List<dynamic>?,
        empUrlAllRegistration:
            json['emp_url_all_registration'] as List<dynamic>?,
        empForm: json['emp_form'] as List<dynamic>?,
        empIdCard: json['emp_id_card'] as List<dynamic>?,
        empHouse: json['emp_house'] as List<dynamic>?,
        empEducational: json['emp_educational'] as List<dynamic>?,
        empBookBank: (json['emp_book_bank'] as List<dynamic>?)
            ?.map((e) => EmpBookBank.fromJson(e as Map<String, dynamic>))
            .toList(),
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
        'social_security': socialSecurity?.map((e) => e.toJson()).toList(),
        'address': address,
        'fnames': fnames?.toJson(),
        'lnames': lnames?.toJson(),
        'nnames': nnames?.toJson(),
        'profile_image': profileImage,
        'ability_image': abilityImage,
        'license_image': licenseImage,
        'training_image': trainingImage,
        'certificate_file_one':
            certificateFileOne?.map((e) => e.toJson()).toList(),
        'certificate_file_two':
            certificateFileTwo?.map((e) => e.toJson()).toList(),
        'bank': bank,
        'emergency': emergency,
        'education': education,
        'work_experience': workExperience,
        'department': department?.toJson(),
        'position': position?.toJson(),
        'character': character?.toJson(),
        'salary': salary,
        'skill': skill,
        'benefit': benefit,
        'my_car': myCar?.toJson(),
        'company': company?.toJson(),
        'group_insurance': groupInsurance,
        'emp_url_all_contract': empUrlAllContract,
        'emp_contract': empContract,
        'emp_confidentiality': empConfidentiality,
        'emp_competition': empCompetition,
        'emp_paid_training': empPaidTraining,
        'emp_asset_loan': empAssetLoan,
        'emp_saving_contract': empSavingContract,
        'emp_url_all_registration': empUrlAllRegistration,
        'emp_form': empForm,
        'emp_id_card': empIdCard,
        'emp_house': empHouse,
        'emp_educational': empEducational,
        'emp_book_bank': empBookBank?.map((e) => e.toJson()).toList(),
      };
}
