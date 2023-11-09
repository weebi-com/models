import 'dart:convert';

import 'package:models_weebi/src/base_dummies/article.dart';
import 'package:models_weebi/utils.dart';
import 'package:test/test.dart';

void main() {
  test('article', () {
    final _json = ArticleDummy().toJson();
    final Map<String, dynamic> map = (json.decode(_json));
    expect(map['id'], 1);
    expect(map['calibreId'], 1);
    expect(map['fullName'], 'frometon forever');
    expect(map['weight'], 1);
    expect(map['articleCode'], 11);
    expect(map['creationDate'], WeebiDates.defaultDate.toIso8601String());
    expect(map['status'], true);
  });
}
