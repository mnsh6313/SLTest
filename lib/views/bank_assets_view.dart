import 'package:flutter/material.dart';
import 'package:sl_test/view_models/bank_assets_datasource.dart';
import 'package:sl_test/view_models/bank_assets_vm.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class BankAssetsView extends StatefulWidget {
  final String? symbol;
  const BankAssetsView({super.key, this.symbol});

  @override
  State<BankAssetsView> createState() => _BankAssetsViewState();
}

class _BankAssetsViewState extends State<BankAssetsView> {
  late BankAssetsVM _model;
  late BankAssetsDataSource _bankAssetsDataSource;
  late Map<String, double> columnWidths = {};
  List bankAssets = [];

  @override
  void initState() {
    super.initState();
    _model = BankAssetsVM(bankSymbol: widget.symbol);
    _model.loadBankAssets((bankAssets) {
      _bankAssetsDataSource = BankAssetsDataSource(bankAssets);
      _bankAssetsDataSource.getCells().forEach((DataGridCell cell) {
        columnWidths[cell.columnName] = double.nan;
      });
      setState(() {
        this.bankAssets = bankAssets;
      });
    }); // Load bank details
  }

  @override
  Widget build(BuildContext context) {
    if (bankAssets.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return _getAssetsTable(bankAssets);
  }

  // Get asset table
  Widget _getAssetsTable(List bankAssets) {
    List<GridColumn> columns =
        _bankAssetsDataSource.getCells().map<GridColumn>((DataGridCell e) {
      return GridColumn(
          width: columnWidths[e.columnName]!,
          columnName: e.columnName,
          label: Container(
              color: Colors.grey[300],
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
              child: Text(
                e.columnName == "asset_name" ? "Particulars" : e.columnName,
                style: const TextStyle(
                    color: Colors.black, overflow: TextOverflow.ellipsis),
              )));
    }).toList();
    return SfDataGridTheme(
      data:
          SfDataGridThemeData(frozenPaneElevation: 0.0, frozenPaneLineWidth: 0),
      child: SfDataGrid(
        allowColumnsResizing: true,
        onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
          setState(() {
            columnWidths[details.column.columnName] = details.width;
          });
          return true;
        },
        source: _bankAssetsDataSource,
        columns: columns,
        frozenColumnsCount: 1,
        gridLinesVisibility: GridLinesVisibility.none,
        headerGridLinesVisibility: GridLinesVisibility.none,
      ),
    );
  }
}
