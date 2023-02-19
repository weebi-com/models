import 'package:sembast/sembast.dart';

class DbStoresClosings {
  static final closingHerdersStoreDb =
      intMapStoreFactory.store('closing_herders');
  static final closingLedgersStoreDb =
      intMapStoreFactory.store('closing_ledgers');
  static final closingLedgerShopsStoreDb =
      intMapStoreFactory.store('closing_ledger_shops');
  static final closingRangesStoreDb =
      intMapStoreFactory.store('closing_ranges');
  static final closingStocksStoreDb =
      intMapStoreFactory.store('closing_stocks');
  static final closingStockShopsStoreDb =
      intMapStoreFactory.store('closing_stock_shops');
  static final closingStockProductsStoreDb =
      intMapStoreFactory.store('closing_stock_products');
  static final closingHerderStocksStoreDb =
      intMapStoreFactory.store('closing_stocks_herders');
}
