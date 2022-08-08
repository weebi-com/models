import 'package:collection/collection.dart';
import 'package:models_weebi/src/weebi/article_weebi.dart';
import 'package:test/test.dart';

void main() {
  test('productWeebi', () {
    final _json = ArticleWeebi.dummy.toJson();
    final dummy = ArticleWeebi.fromJson(_json);
    // expect(dummy == ArticleWeebi.dummy, isTrue);
    expect(dummy.shopUuid == ArticleWeebi.dummy.shopUuid, isTrue);
    expect(dummy.id == ArticleWeebi.dummy.id, isTrue);
    expect(dummy.lineId == ArticleWeebi.dummy.lineId, isTrue);
    expect(dummy.fullName == ArticleWeebi.dummy.fullName, isTrue);
    expect(dummy.price == ArticleWeebi.dummy.price, isTrue);
    expect(dummy.cost == ArticleWeebi.dummy.cost, isTrue);
    expect(dummy.weight == ArticleWeebi.dummy.weight, isTrue);
    expect(dummy.articleCode == ArticleWeebi.dummy.articleCode, isTrue);
    expect(dummy.photo == ArticleWeebi.dummy.photo, isTrue);
    expect(dummy.creationDate == ArticleWeebi.dummy.creationDate, isTrue);
    expect(dummy.status == ArticleWeebi.dummy.status, isTrue);
    final listEquals = const DeepCollectionEquality().equals;
    // expect(listEquals(dummy.lots, ArticleWeebi.dummy.lots), isTrue);
  });
  //TODO make a ArticleBasket test
}