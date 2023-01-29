import 'package:models_weebi/src/models/herder_weebi.dart';
import 'package:test/test.dart';

void main() {
  test('herderWeebi', () {
    final json = HerderWeebi.dummy.toJson();
    final dummy = HerderWeebi.fromJson(json);
    expect(dummy == HerderWeebi.dummy, isTrue);
  });
}
