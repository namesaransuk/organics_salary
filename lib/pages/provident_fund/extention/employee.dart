import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organics_salary/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProvidentFund {
  /// Creates the employee class with required details.

  final String month;
  final String reserve;
  final String contribution;
  final String total_month;
  final String accumulate_balance;
  ProvidentFund(
    this.month,
    this.reserve,
    this.contribution,
    this.total_month,
    this.accumulate_balance,
  );
}

class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<ProvidentFund> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'month', value: e.month),
              DataGridCell<String>(columnName: 'reserve', value: e.reserve),
              DataGridCell<String>(
                  columnName: 'contribution', value: e.contribution),
              DataGridCell<String>(
                  columnName: 'total_month', value: e.total_month),
              DataGridCell<String>(
                  columnName: 'accumulate_balance',
                  value: e.accumulate_balance),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          e.value.toString(),
          textAlign: TextAlign.center,
          style: GoogleFonts.kanit(
            textStyle: TextStyle(
              color: e.columnName == 'total_month'
                  ? Colors.green
                  : AppTheme.ognGreen,
              fontSize: 12,
            ),
          ),
        ),
      );
    }).toList());
  }
}
