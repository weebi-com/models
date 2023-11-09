import 'dart:convert';

import 'package:models_weebi/src/base_dummies/taxe.dart';
import 'package:test/test.dart';

void main() {
  test('taxe', () {
    final _json = TaxDummy().toJson();
    final Map<String, dynamic> map = (json.decode(_json));

    expect(map['id'] == '1', isTrue);
    expect(map['name'] == 'noTax', isTrue);
    expect(map['percentage'] == 0.0, isTrue);
  });
}
