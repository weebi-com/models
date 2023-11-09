import 'dart:convert';
import 'package:models_weebi/src/base_dummies/item.dart';
import 'package:models_weebi/utils.dart';
import 'package:test/test.dart';

void main() {
  test('item', () {
    final _json = ItemDummy().toJson();
    final Map<String, dynamic> map = (json.decode(_json));

    final Map<String, dynamic> mapA = map['article'];
    expect(mapA['id'] == 1, isTrue);
    expect(mapA['calibreId'] == 1, isTrue);
    expect(mapA['fullName'] == 'frometon forever', isTrue);
    // expect(mapA['price'] == 1000, isTrue);
    // expect(mapA['cost'] == 500, isTrue);
    expect(mapA['weight'] == 1, isTrue);
    expect(mapA['articleCode'] == 11, isTrue);
    expect(mapA['creationDate'] == WeebiDates.defaultDate.toIso8601String(),
        isTrue);
    expect(mapA['status'] == true, isTrue);

    // for basket dummy
    // final Map<String, dynamic> mapPxWorth = map['proxies_worth'][0];
    // expect(mapPxWorth['calibreId'] == 1, isTrue);
    // expect(mapPxWorth['articleId'] == 1, isTrue);
    // expect(mapPxWorth['id'] == 1, isTrue);
    // expect(mapPxWorth['proxyCalibreId'] == 1, isTrue);
    // expect(mapPxWorth['proxyArticleId'] == 1, isTrue);
    // expect(mapPxWorth['status'] == true, isTrue);

    // Item.quantity
    expect(map['quantity'] == 2.0, isTrue);
  });
}
