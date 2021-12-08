import 'package:models_weebi/src/weebi/lot_weebi.dart';
import 'package:test/test.dart';

void main() {
  test('lot weebi', () {
    final _json = LotWeebi.dummy.toJson();
    final dummy = LotWeebi.fromJson(_json);
    expect(dummy.id == LotWeebi.dummy.id, isTrue);
    expect(dummy.articleId == LotWeebi.dummy.articleId, isTrue);
    expect(dummy.productId == LotWeebi.dummy.productId, isTrue);
    expect(dummy.isDefault == LotWeebi.dummy.isDefault, isTrue);
  });
}
