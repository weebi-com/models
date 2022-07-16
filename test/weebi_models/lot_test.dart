import 'package:models_weebi/src/weebi/lot_weebi.dart';
import 'package:test/test.dart';

void main() {
  test('lot weebi', () {
    final _json = LotWeebi.dummy.toJson();
    final dummy = LotWeebi.fromJson(_json);
    expect(dummy.lineId == LotWeebi.dummy.lineId, isTrue);
    expect(dummy.articleId == LotWeebi.dummy.articleId, isTrue);
    expect(dummy.id == LotWeebi.dummy.id, isTrue);
    expect(dummy.isDefault == LotWeebi.dummy.isDefault, isTrue);
  });
}
