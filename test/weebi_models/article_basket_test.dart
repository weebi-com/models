// import 'package:models_weebi/src/models/article_weebi.dart';
import 'package:models_weebi/weebi_models.dart';
import 'package:test/test.dart';
import 'package:collection/collection.dart';

void main() {
  test('article basket with price and cost', () {
    final dummy = ArticleBasket.dummy;

    //expect(dummy.price, 100);
    //expect(dummy.cost, 80);
    // ArticleBasket.dummy == x2 LineArticleWeebi.dummy with price: 100, cost: 80,

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
    expect(listEquals(dummy.proxies, ArticleBasket.dummy.proxies), isTrue);
  });
}
