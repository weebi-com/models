import 'package:models_weebi/src/weebi/shop_weebi.dart';
import 'package:test/test.dart';

void main() {
  test('shop yobi', () {
    final _json = ShopWeebi.unknownShopWeebi.toJson();
    final unknownShopWeebi = ShopWeebi.fromJson(_json);

    expect(unknownShopWeebi == ShopWeebi.unknownShopWeebi, isTrue);
  });
}
