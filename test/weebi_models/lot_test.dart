import 'package:models_weebi/src/weebi/lot_weebi.dart';
import 'package:test/test.dart';

void main() {
  test('lot yobi', () {
    final _json = LotWeebi.dummy.toJson();
    final dummy = LotWeebi.fromJson(_json);
    expect(dummy == LotWeebi.dummy, isTrue);
  });
}
