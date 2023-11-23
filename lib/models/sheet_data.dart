class SheetData {
  final String columnA;
  final String columnB;

  SheetData({required this.columnA, required this.columnB});

  factory SheetData.fromJson(Map<String, dynamic> json) {
    return SheetData(
      columnA: json['A'],
      columnB: json['B'],
    );
  }
}
