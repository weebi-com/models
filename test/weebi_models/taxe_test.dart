import 'package:models_weebi/src/weebi/taxe_weebi.dart';
import 'package:test/test.dart';

void main() {
  test('taxe weebi', () {
    final _json = TaxeWeebi.noTax.toJson();
    final dummy = TaxeWeebi.fromJson(_json);

    expect(dummy.id == TaxeWeebi.noTax.id, isTrue);
    expect(dummy.name == TaxeWeebi.noTax.name, isTrue);
    expect(dummy.percentage == TaxeWeebi.noTax.percentage, isTrue);
  });
}
