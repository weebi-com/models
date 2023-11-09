import 'dart:convert';

import 'package:models_weebi/src/base_dummies/article_calibre.dart';
import 'package:models_weebi/utils.dart';
import 'package:models_weebi/common.dart' show StockUnit;
import 'package:test/test.dart';

void main() {
  test('ArticleCalibreDummy serialisation', () {
    final _json = ArticleCalibreDummy().toJson();
    final Map<String, dynamic> map = (json.decode(_json));

    final Map<String, dynamic> mapA = map['articles'][0];
    expect(mapA['id'], 1);
    expect(mapA['calibreId'], 1);
    expect(mapA['fullName'], 'frometon forever');
    expect(mapA['weight'], 1);
    expect(mapA['articleCode'], 11);
    expect(mapA['creationDate'], WeebiDates.defaultDate.toIso8601String());
    expect(mapA['status'], true);

    expect(map['categories'].first, 'categories');

    expect(StockUnit.unit, StockUnit.tryParse(map['stockUnit']));

    expect(map['id'], 1);
    expect(map['title'], 'frometon');
    expect(map['status'], true);
    expect(map['barcode'], 1);
    expect(map['statusUpdateDate'], WeebiDates.defaultDate.toIso8601String());
    expect(map['creationDate'], WeebiDates.defaultDate.toIso8601String());
  });
}
