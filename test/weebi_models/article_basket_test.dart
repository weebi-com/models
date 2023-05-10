// import 'package:models_weebi/src/models/article_weebi.dart';
import 'package:models_weebi/weebi_models.dart';
import 'package:test/test.dart';
import 'package:collection/collection.dart';

void main() {
  test('article basket with price and cost', () {
    final json = ArticleBasket.dummy.toJson();
    final dummy = ArticleBasket.fromJson(json);
    // ArticleBasket.dummy == x2 LineArticleRetail.dummy with price: 100, cost: 80,
    //ArticleLine.dummyBast has a price of 100);
    //ArticleLine.dummyBast has a cost of 80);
    final proxiesWorth = dummy.getProxiesListWithPriceAndCost(
        [ArticleLine.dummy]); // mocking a list of articles in the store

    expect(dummy.id == ArticleBasket.dummy.id, isTrue);
    expect(dummy.lineId == ArticleBasket.dummy.lineId, isTrue);
    expect(dummy.fullName == ArticleBasket.dummy.fullName, isTrue);

    expect(proxiesWorth.totalPrice == 100, isTrue);
    expect(proxiesWorth.totalCost == 80, isTrue);
    expect(dummy.articleCode == ArticleBasket.dummy.articleCode, isTrue);
    expect(dummy.photo == ArticleBasket.dummy.photo, isTrue);
    expect(dummy.creationDate == ArticleBasket.dummy.creationDate, isTrue);
    expect(dummy.status == ArticleBasket.dummy.status, isTrue);
    final listEquals = const DeepCollectionEquality().equals;
    expect(listEquals(dummy.proxies, ArticleBasket.dummy.proxies), isTrue);
  });
}
