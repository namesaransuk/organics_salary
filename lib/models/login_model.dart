class LoginModel {
  int? id;
  int? companyId;
  int? positionId;
  dynamic departmentId;
  String? employeeCardId;
  String? employeeCode;
  String? preName;
  String? fName;
  String? lName;
  String? nName;
  String? genderId;
  String? birthday;
  String? mobile;
  String? cardAdd;
  String? currentAdd;
  String? idCard;
  String? startDate;
  String? endDate;
  dynamic yExperience;
  dynamic image;
  int? recordStatus;
  dynamic coins;
  String? username;
  String? password;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? accessToken;
  String? status;
  String? statusCode;

  LoginModel({
    this.id,
    this.companyId,
    this.positionId,
    this.departmentId,
    this.employeeCardId,
    this.employeeCode,
    this.preName,
    this.fName,
    this.lName,
    this.nName,
    this.genderId,
    this.birthday,
    this.mobile,
    this.cardAdd,
    this.currentAdd,
    this.idCard,
    this.startDate,
    this.endDate,
    this.yExperience,
    this.image,
    this.recordStatus,
    this.coins,
    this.username,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.accessToken,
    this.status,
    this.statusCode,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        id: json['id'] as int?,
        companyId: json['company_id'] as int?,
        positionId: json['position_id'] as int?,
        departmentId: json['department_id'] as dynamic,
        employeeCardId: json['employee_card_id'] as String?,
        employeeCode: json['employee_code'] as String?,
        preName: json['pre_name'] as String?,
        fName: json['f_name'] as String?,
        lName: json['l_name'] as String?,
        nName: json['n_name'] as String?,
        genderId: json['gender_id'] as String?,
        birthday: json['birthday'] as String?,
        mobile: json['mobile'] as String?,
        cardAdd: json['card_add'] as String?,
        currentAdd: json['current_add'] as String?,
        idCard: json['id_card'] as String?,
        startDate: json['start_date'] as String?,
        endDate: json['end_date'] as String?,
        yExperience: json['y_experience'] as dynamic,
        image: json['image'] as dynamic,
        recordStatus: json['record_status'] as int?,
        coins: json['coins'] as dynamic,
        username: json['username'] as String?,
        password: json['password'] as String?,
        // createdAt: json['created_at'] == null
        //     ? null
        //     : DateTime.parse(json['created_at'] as String),
        // updatedAt: json['updated_at'] == null
        //     ? null
        //     : DateTime.parse(json['updated_at'] as String),
        accessToken: json['access_token'] as String?,
        status: json['status'] as String?,
        statusCode: json['statusCode'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'company_id': companyId,
        'position_id': positionId,
        'department_id': departmentId,
        'employee_card_id': employeeCardId,
        'employee_code': employeeCode,
        'pre_name': preName,
        'f_name': fName,
        'l_name': lName,
        'n_name': nName,
        'gender_id': genderId,
        'birthday': birthday,
        'mobile': mobile,
        'card_add': cardAdd,
        'current_add': currentAdd,
        'id_card': idCard,
        'start_date': startDate,
        'end_date': endDate,
        'y_experience': yExperience,
        'image': image,
        'record_status': recordStatus,
        'coins': coins,
        'username': username,
        'password': password,
        // 'created_at': createdAt!.toIso8601String(),
        // 'updated_at': updatedAt!.toIso8601String(),
        'access_token': accessToken,
        'status': status,
        'statusCode': statusCode,
      };
}
