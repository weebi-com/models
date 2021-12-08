import 'package:models_weebi/src/weebi/product_weebi.dart';
import 'package:test/test.dart';

void main() {
  test('product weebi json', () {
    final _json = ProductWeebi.dummy.toJson();
    final dummy = ProductWeebi.fromJson(_json);
    // expect(dummy == ProductWeebi.dummy, isTrue);
    expect(dummy.id == ProductWeebi.dummy.id, isTrue);
    expect(dummy.status == ProductWeebi.dummy.status, isTrue);
    expect(dummy.creationDate == ProductWeebi.dummy.creationDate, isTrue);
  });
}
