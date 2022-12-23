import 'package:models_weebi/src/models/item_cart_weebi.dart';
import 'package:test/test.dart';

void main() {
  test('item weebi', () {
    final _json = ItemCartWeebi.dummy.toJson();
    final dummy = ItemCartWeebi.fromJson(_json);
    //print(dummy);
    //print(ItemCartWeebi.dummy);
    expect(dummy == ItemCartWeebi.dummy, isTrue);
  });
}
