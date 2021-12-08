import 'package:models_weebi/src/weebi/taxe_weebi.dart';
import 'package:test/test.dart';

void main() {
  test('taxe weebi', () {
    final _json = TaxeWeebi.noTax.toJson();
    final dummy = TaxeWeebi.fromJson(_json);

    expect(dummy == TaxeWeebi.noTax, isTrue);
  });
}
