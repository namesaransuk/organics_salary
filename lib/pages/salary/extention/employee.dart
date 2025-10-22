import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organics_salary/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Employee {
  /// Creates the employee class with required details.

  final String month;
  final String netPay;
  final String datetime;
  final String datesearch;
  Employee(this.month, this.netPay, this.datetime, this.datesearch);
}

class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<Employee> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'month', value: e.month),
              DataGridCell<String>(columnName: 'salary', value: e.netPay),
              DataGridCell<String>(columnName: 'datetime', value: e.datetime),
              DataGridCell<String>(
                  columnName: 'datesearch', value: e.datesearch),
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
              color:
                  e.columnName == 'salary' ? Colors.green : AppTheme.ognGreen,
              fontSize: 12,
            ),
          ),
        ),
      );
    }).toList());
  }
}
