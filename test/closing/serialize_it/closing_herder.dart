import 'dart:convert';

import 'package:models_weebi/closings.dart';
import 'package:test/test.dart';

void main() {
  test('herder', () {
    final _json = ClosingLedgerHerder.dummyMar2020.toJson();
    final Map<String, dynamic> map = (json.decode(_json));
    expect(map['herderId'] == '1', isTrue);
  });
}
