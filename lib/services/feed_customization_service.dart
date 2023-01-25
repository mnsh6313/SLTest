///@author ManishPoudel
///@createdAt 1/25/2023
/// Service class that customizes the raw data based on our requirements

class FeedCustomization {
  // Customize bank asset data for our requirements
  Map<String, dynamic> customizeBankAssetData(Map<String, dynamic> rawAssets) {
    Map<String, dynamic> customAssets = {};
    // Loop through each assets
    rawAssets.forEach((key, value) {
      // Loop through each particulars in assets

      if (value.isEmpty) {
        return;
      }
      // If the year doesn't contain any value, return

      for (Map<String, dynamic> rawParticulars in value) {
        String assetName = rawParticulars["asset_name"];
        // Check if the particular assets is contained in custom assets map. If not, create new one for the particular
        // asset and update the asset value by year.
        if (!customAssets.containsKey(assetName)) {
          customAssets[assetName] = {
            "asset_name": assetName,
          };
        }
        customAssets[assetName][key] = rawParticulars["asset_value"].toString();
      }
    });
    return customAssets;
  }
}
