import 'package:models_weebi/src/weebi/herder_weebi.dart';
import 'package:test/test.dart';

void main() {
  test('herderYobi', () {
    final _json = HerderWeebi.dummy.toJson();
    final dummy = HerderWeebi.fromJson(_json);
    expect(dummy == HerderWeebi.dummy, isTrue);
  });
}
