import 'package:flutter/services.dart';

///@author ManishPoudel
///@createdAt 1/25/2023
/// Service class that encapsulates the logic for retrieving bank data from storage.

class BankFeedService {
  /// Function to load bank data currently from asset file
  loadData({String? symbol = "ADBL"}) async {
    try {
      final String response =
          await rootBundle.loadString(_getStoragePath(symbol));
      return response;
    } catch (err) {
      return null;
    }
  }

  // Get storage path based on the company symbol
  _getStoragePath(symbol) {
    if (symbol == "ADBL") return "assets/adbl.json";
  }
}
