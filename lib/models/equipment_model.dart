class EquipmentModel {
  int? id;
  int? empId;
  int? pickupToolsId;
  String? deviceTypesName;
  String? unit;
  String? image;
  String? requestDetails;
  int? numberRequestedLimit;
  int? numberRequested;
  int? statusApproved;
  String? createdAt;
  String? updatedAt;
  String? approveAt;
  String? cancelAt;
  String? rejectAt;
  String? registrationNumber;
  int? statusRepair;

  EquipmentModel({
    this.id,
    this.empId,
    this.pickupToolsId,
    this.deviceTypesName,
    this.unit,
    this.image,
    this.requestDetails,
    this.numberRequestedLimit,
    this.numberRequested,
    this.statusApproved,
    this.createdAt,
    this.updatedAt,
    this.approveAt,
    this.cancelAt,
    this.rejectAt,
    this.registrationNumber,
    this.statusRepair,
  });

  factory EquipmentModel.fromJson(Map<String, dynamic> json) {
    return EquipmentModel(
      id: json['id'] as int?,
      empId: json['emp_id'] as int?,
      pickupToolsId: json['pickup_tools_id'] as int?,
      deviceTypesName: json['device_types_name'] as String?,
      unit: json['unit'] as String?,
      image: json['image'] as String?,
      requestDetails: json['request_details'] as String?,
      numberRequestedLimit: json['number_requested_limit'] as int?,
      numberRequested: json['number_requested'] as int?,
      statusApproved: json['status_approved'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      approveAt: json['approve_at'] as String?,
      cancelAt: json['cancel_at'] as String?,
      rejectAt: json['reject_at'] as String?,
      registrationNumber: json['registration_number'] as String?,
      statusRepair: json['status_repair'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'emp_id': empId,
        'pickup_tools_id': pickupToolsId,
        'device_types_name': deviceTypesName,
        'unit': unit,
        'image': image,
        'request_details': requestDetails,
        'number_requested_limit': numberRequestedLimit,
        'number_requested': numberRequested,
        'status_approved': statusApproved,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'approve_at': approveAt,
        'cancel_at': cancelAt,
        'reject_at': rejectAt,
        'registration_number': registrationNumber,
        'status_repair': statusRepair,
      };
}
