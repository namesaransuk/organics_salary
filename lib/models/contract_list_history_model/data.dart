import 'emp_asset_loan.dart';
import 'emp_book_bank.dart';
import 'emp_competition.dart';
import 'emp_confidentiality.dart';
import 'emp_contract.dart';
import 'emp_educational.dart';
import 'emp_form.dart';
import 'emp_house.dart';
import 'emp_id_card.dart';
import 'emp_paid_training.dart';
import 'emp_saving_contract.dart';

class ContractData {
  List<EmpContract>? empContract;
  List<EmpConfidentiality>? empConfidentiality;
  List<EmpCompetition>? empCompetition;
  List<EmpPaidTraining>? empPaidTraining;
  List<EmpAssetLoan>? empAssetLoan;
  List<EmpSavingContract>? empSavingContract;
  List<EmpForm>? empForm;
  List<EmpIdCard>? empIdCard;
  List<EmpHouse>? empHouse;
  List<EmpEducational>? empEducational;
  List<EmpBookBank>? empBookBank;

  ContractData({
    this.empContract,
    this.empConfidentiality,
    this.empCompetition,
    this.empPaidTraining,
    this.empAssetLoan,
    this.empSavingContract,
    this.empForm,
    this.empIdCard,
    this.empHouse,
    this.empEducational,
    this.empBookBank,
  });

  factory ContractData.fromJson(Map<String, dynamic> json) => ContractData(
        empContract: (json['emp_contract'] as List<dynamic>?)
            ?.map((e) => EmpContract.fromJson(e as Map<String, dynamic>))
            .toList(),
        empConfidentiality: (json['emp_confidentiality'] as List<dynamic>?)
            ?.map((e) => EmpConfidentiality.fromJson(e as Map<String, dynamic>))
            .toList(),
        empCompetition: (json['emp_competition'] as List<dynamic>?)
            ?.map((e) => EmpCompetition.fromJson(e as Map<String, dynamic>))
            .toList(),
        empPaidTraining: (json['emp_paid_training'] as List<dynamic>?)
            ?.map((e) => EmpPaidTraining.fromJson(e as Map<String, dynamic>))
            .toList(),
        empAssetLoan: (json['emp_asset_loan'] as List<dynamic>?)
            ?.map((e) => EmpAssetLoan.fromJson(e as Map<String, dynamic>))
            .toList(),
        empSavingContract: (json['emp_saving_contract'] as List<dynamic>?)
            ?.map((e) => EmpSavingContract.fromJson(e as Map<String, dynamic>))
            .toList(),
        empForm: (json['emp_form'] as List<dynamic>?)
            ?.map((e) => EmpForm.fromJson(e as Map<String, dynamic>))
            .toList(),
        empIdCard: (json['emp_id_card'] as List<dynamic>?)
            ?.map((e) => EmpIdCard.fromJson(e as Map<String, dynamic>))
            .toList(),
        empHouse: (json['emp_house'] as List<dynamic>?)
            ?.map((e) => EmpHouse.fromJson(e as Map<String, dynamic>))
            .toList(),
        empEducational: (json['emp_educational'] as List<dynamic>?)
            ?.map((e) => EmpEducational.fromJson(e as Map<String, dynamic>))
            .toList(),
        empBookBank: (json['emp_book_bank'] as List<dynamic>?)
            ?.map((e) => EmpBookBank.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'emp_contract': empContract?.map((e) => e.toJson()).toList(),
        'emp_confidentiality':
            empConfidentiality?.map((e) => e.toJson()).toList(),
        'emp_competition': empCompetition?.map((e) => e.toJson()).toList(),
        'emp_paid_training': empPaidTraining?.map((e) => e.toJson()).toList(),
        'emp_asset_loan': empAssetLoan?.map((e) => e.toJson()).toList(),
        'emp_saving_contract':
            empSavingContract?.map((e) => e.toJson()).toList(),
        'emp_form': empForm?.map((e) => e.toJson()).toList(),
        'emp_id_card': empIdCard?.map((e) => e.toJson()).toList(),
        'emp_house': empHouse?.map((e) => e.toJson()).toList(),
        'emp_educational': empEducational?.map((e) => e.toJson()).toList(),
        'emp_book_bank': empBookBank?.map((e) => e.toJson()).toList(),
      };
}
