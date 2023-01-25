import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sl_test/services/bank_feed_service.dart';
import 'package:sl_test/services/feed_customization_service.dart';

///@author ManishPoudel
///@createdAt 1/25/2023
/// View Model class for Bank details view for handling all business logics

class BankAssetsVM with ChangeNotifier {
  late BankFeedService _bankFeedService;
  String? _bankSymbol = "ADBL";

  BankAssetsVM({String? bankSymbol}) {
    _bankFeedService = BankFeedService();
    _bankSymbol = bankSymbol;
  }

  // Load bank assets
  loadBankAssets(Function onLoad) async {
    Map<String, dynamic> rawBankAssets = Map<String, dynamic>.from(jsonDecode(
        await _bankFeedService.loadData(
            symbol: _bankSymbol))); // Get raw data of the bank
    // Get dynamically customized bank asset data that is created from raw data for our specific ui requirements
    Map<String, dynamic> customizedBankAssets =
        FeedCustomization().customizeBankAssetData(rawBankAssets["assets"]);
    Function.apply(onLoad, [customizedBankAssets.values.toList()]);
  }
}
