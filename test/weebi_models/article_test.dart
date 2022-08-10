import 'package:models_weebi/src/weebi/article_weebi.dart';
import 'package:models_weebi/weebi_models.dart';
import 'package:test/test.dart';
import 'package:collection/collection.dart';

void main() {
  test('article Weebi', () {
    final _json = ArticleBasket.dummy.toJson();
    final dummy = ArticleBasket.fromJson(_json);
    // expect(dummy == ArticleBasket.dummy, isTrue);
    expect(dummy.shopUuid == ArticleBasket.dummy.shopUuid, isTrue);
    expect(dummy.id == ArticleBasket.dummy.id, isTrue);
    expect(dummy.lineId == ArticleBasket.dummy.lineId, isTrue);
    expect(dummy.fullName == ArticleBasket.dummy.fullName, isTrue);
    expect(dummy.price == ArticleBasket.dummy.price, isTrue);
    expect(dummy.cost == ArticleBasket.dummy.cost, isTrue);
    expect(dummy.weight == ArticleBasket.dummy.weight, isTrue);
    expect(dummy.articleCode == ArticleBasket.dummy.articleCode, isTrue);
    expect(dummy.photo == ArticleBasket.dummy.photo, isTrue);
    expect(dummy.creationDate == ArticleBasket.dummy.creationDate, isTrue);
    expect(dummy.status == ArticleBasket.dummy.status, isTrue);
    final listEquals = const DeepCollectionEquality().equals;
    expect(listEquals(dummy.lots, ArticleBasket.dummy.lots), isTrue);
  });
  //TODO make a ArticleBasket test
}
