import 'package:models_weebi/src/models/taxe_weebi.dart';
import 'package:test/test.dart';

void main() {
  test('taxe weebi', () {
    final json = TaxWeebi.noTax.toJson();
    final dummy = TaxWeebi.fromJson(json);

    expect(dummy.id == TaxWeebi.noTax.id, isTrue);
    expect(dummy.name == TaxWeebi.noTax.name, isTrue);
    expect(dummy.percentage == TaxWeebi.noTax.percentage, isTrue);
  });
}
