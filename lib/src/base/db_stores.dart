import 'package:sembast/sembast.dart';

abstract class DbStoresBase {
  final herders = intMapStoreFactory.store('herders');
  final shops = intMapStoreFactory.store('shops');
  final tickets = intMapStoreFactory.store('tickets');
  final taxes = intMapStoreFactory.store('taxes');
  final articles = intMapStoreFactory.store('articles');
  final loans = intMapStoreFactory.store('loans');
  //final managers = intMapStoreFactory.store('managers');
}
