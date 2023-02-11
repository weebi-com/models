import 'package:models_weebi/src/models/herder.dart';
import 'package:test/test.dart';

void main() {
  test('herderWeebi', () {
    final _json = Herder.dummy.toJson();
    final dummy = Herder.fromJson(_json);
    expect(dummy == Herder.dummy, isTrue);
  });
}
