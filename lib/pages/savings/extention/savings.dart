import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organics_salary/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Savings {
  /// Creates the Savings class with required details.

  final String month;
  final String netPay;
  final String datetime;
  final String datesearch;
  Savings(this.month, this.netPay, this.datetime, this.datesearch);
}

class SavingsDataSource extends DataGridSource {
  /// Creates the Savings data source class with required details.
  SavingsDataSource({required List<Savings> savingsData}) {
    _savingsData = savingsData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'month', value: e.month),
              DataGridCell<String>(columnName: 'salary', value: e.netPay),
              DataGridCell<String>(columnName: 'datetime', value: e.datetime),
              DataGridCell<String>(
                  columnName: 'datesearch', value: e.datesearch),
            ]))
        .toList();
  }

  List<DataGridRow> _savingsData = [];

  @override
  List<DataGridRow> get rows => _savingsData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      bool isSalaryColumn = e.columnName == 'salary';
      bool isPositiveSalary = e.value.toString().startsWith('+');
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          e.value.toString(),
          textAlign: TextAlign.center,
          style: GoogleFonts.kanit(
            textStyle: TextStyle(
              // color: e.columnName == 'salary' && e.value.startsWith('+') ? Colors.green : Colors.red,
              color: isSalaryColumn && isPositiveSalary
                  ? Colors.green
                  : (isSalaryColumn ? Colors.red : AppTheme.ognGreen),
              fontSize: 12,
            ),
          ),
        ),
      );
    }).toList());
  }
}
