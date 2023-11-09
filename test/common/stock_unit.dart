import 'package:models_weebi/common.dart';
import 'package:test/test.dart';

void main() {
  test('box', () {
    final _json = {'stockUnit': StockUnit.unit.toString()};
    // final Map<String, dynamic> map = (json.decode(_json));
    final st = StockUnit.tryParse(_json['stockUnit'] ?? '');
    expect(st == StockUnit.unit, isTrue);
  });
}
