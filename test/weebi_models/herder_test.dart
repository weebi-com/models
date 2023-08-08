import 'package:models_weebi/src/models/herder.dart';
import 'package:test/test.dart';

void main() {
  test('herderWeebi', () {
    final json = Herder.dummyJohnDoeId1.toJson();
    final dummy = Herder.fromJson(json);
    expect(dummy == Herder.dummyJohnDoeId1, isTrue);
  });
}
