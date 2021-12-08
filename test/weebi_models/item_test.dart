import 'package:models_weebi/src/weebi/item_weebi.dart';
import 'package:test/test.dart';

void main() {
  test('item weebi', () {
    final _json = ItemWeebi.dummy.toJson();
    final dummy = ItemWeebi.fromJson(_json);
    expect(dummy == ItemWeebi.dummy, isTrue);
  });
}
