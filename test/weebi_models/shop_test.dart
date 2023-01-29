import 'package:models_weebi/src/models/shop_weebi.dart';
import 'package:test/test.dart';

void main() {
  test('shop weebi', () {
    final json = ShopWeebi.unknownShopWeebi.toJson();
    final unknownShopWeebi = ShopWeebi.fromJson(json);

    expect(unknownShopWeebi == ShopWeebi.unknownShopWeebi, isTrue);
  });
}
