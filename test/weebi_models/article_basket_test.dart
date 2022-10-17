// import 'package:models_weebi/src/models/article_weebi.dart';
import 'package:models_weebi/weebi_models.dart';
import 'package:test/test.dart';
import 'package:collection/collection.dart';

void main() {
  test('article basket with price and cost', () {
    final dummy = ArticleBasketWithPriceAndCost.dummyWithPriceAndCost;

    //expect(dummy.price, 100);
    //expect(dummy.cost, 80);
    // ArticleBasket.dummy == x2 LineArticleWeebi.dummy with price: 100, cost: 80,

    expect(dummy.id == ArticleBasketWithPriceAndCost.dummyWithPriceAndCost.id,
        isTrue);
    expect(
        dummy.lineId ==
            ArticleBasketWithPriceAndCost.dummyWithPriceAndCost.lineId,
        isTrue);
    expect(
        dummy.fullName ==
            ArticleBasketWithPriceAndCost.dummyWithPriceAndCost.fullName,
        isTrue);
    expect(
        dummy.price ==
            ArticleBasketWithPriceAndCost.dummyWithPriceAndCost.price,
        isTrue);
    expect(
        dummy.cost == ArticleBasketWithPriceAndCost.dummyWithPriceAndCost.cost,
        isTrue);
    expect(
        dummy.weight ==
            ArticleBasketWithPriceAndCost.dummyWithPriceAndCost.weight,
        isTrue);
    expect(
        dummy.articleCode ==
            ArticleBasketWithPriceAndCost.dummyWithPriceAndCost.articleCode,
        isTrue);
    expect(
        dummy.photo ==
            ArticleBasketWithPriceAndCost.dummyWithPriceAndCost.photo,
        isTrue);
    expect(
        dummy.creationDate ==
            ArticleBasketWithPriceAndCost.dummyWithPriceAndCost.creationDate,
        isTrue);
    expect(
        dummy.status ==
            ArticleBasketWithPriceAndCost.dummyWithPriceAndCost.status,
        isTrue);
    final listEquals = const DeepCollectionEquality().equals;
    expect(
        listEquals(dummy.proxies,
            ArticleBasketWithPriceAndCost.dummyWithPriceAndCost.proxies),
        isTrue);
  });
}
