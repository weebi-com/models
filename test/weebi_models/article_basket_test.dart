// import 'package:models_weebi/src/weebi/article_weebi.dart';
import 'package:models_weebi/weebi_models.dart';
import 'package:test/test.dart';
import 'package:collection/collection.dart';

void main() {
  test('article basket ', () {
    final _map = ArticleBasket.dummyNoPriceNoCost.toMap();
    final dummyUnbiuiilt = ArticleBasket.fromMapUnbuiltNoPriceNoCost(_map);
    expect(dummyUnbiuiilt.price, -1);
    expect(dummyUnbiuiilt.cost, -1);
    final dummy = ArticleBasket.gettingPriceAndCost(
      [LineOfArticles.dummy, LineOfArticles.dummy],
      ArticleBasket.dummyNoPriceNoCost,
    );
    //expect(dummy.price, 100);
    //expect(dummy.cost, 80);
    // ArticleBasket.dummy == x2 LineArticleWeebi.dummy with price: 100, cost: 80,
    expect(
        dummy.shopUuid == ArticleBasket.dummyWithPriceAndCost.shopUuid, isTrue);
    expect(dummy.id == ArticleBasket.dummyWithPriceAndCost.id, isTrue);
    expect(dummy.lineId == ArticleBasket.dummyWithPriceAndCost.lineId, isTrue);
    expect(
        dummy.fullName == ArticleBasket.dummyWithPriceAndCost.fullName, isTrue);
    expect(dummy.price == ArticleBasket.dummyWithPriceAndCost.price, isTrue);
    expect(dummy.cost == ArticleBasket.dummyWithPriceAndCost.cost, isTrue);
    expect(dummy.weight == ArticleBasket.dummyWithPriceAndCost.weight, isTrue);
    expect(dummy.articleCode == ArticleBasket.dummyWithPriceAndCost.articleCode,
        isTrue);
    expect(dummy.photo == ArticleBasket.dummyWithPriceAndCost.photo, isTrue);
    expect(
        dummy.creationDate == ArticleBasket.dummyWithPriceAndCost.creationDate,
        isTrue);
    expect(dummy.status == ArticleBasket.dummyWithPriceAndCost.status, isTrue);
    final listEquals = const DeepCollectionEquality().equals;
    expect(
        listEquals(dummy.proxies, ArticleBasket.dummyWithPriceAndCost.proxies),
        isTrue);
  });
}
