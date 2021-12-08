import 'package:models_weebi/src/weebi/product_weebi.dart';
import 'package:test/test.dart';

void main() {
  test('product yobi', () {
    final _json = ProductWeebi.dummy.toJson();
    final dummy = ProductWeebi.fromJson(_json);

    expect(dummy == ProductWeebi.dummy, isTrue);
    //expect(dummy.id == ProductYobi.dummy.id, isTrue);
    //expect(dummy.photo == ProductYobi.dummy.photo, isTrue);
    //expect(dummy.status == ProductYobi.dummy.status, isTrue);
    //expect(dummy.creationDate == ProductYobi.dummy.creationDate, isTrue);
  });
}
