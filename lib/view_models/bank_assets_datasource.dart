import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

///@author ManishPoudel
///@createdAt 1/25/2023
/// Data Source Model class for table
class BankAssetsDataSource extends DataGridSource {
  List<DataGridRow> _bankAssets = [];

  BankAssetsDataSource(List bankAssets) {
    _bankAssets = bankAssets.map<DataGridRow>((assets) {
      return DataGridRow(
          cells: assets.entries.map<DataGridCell>((asset) {
        return DataGridCell(columnName: asset.key, value: asset.value);
      }).toList());
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _bankAssets;

  // Get cells
  getCells() {
    if (_bankAssets.isEmpty) return [];
    return _bankAssets[0].getCells();
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: Text(dataGridCell.value.toString(),
            style: const TextStyle(
                color: Colors.black, overflow: TextOverflow.ellipsis)),
      );
    }).toList());
  }
}
