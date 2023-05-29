// ignore_for_file: unused_element

import 'package:models_weebi/weebi_models.dart';
import 'package:test/test.dart';

// would require to evolve the logic in the way proxies :
// compute mini qt per article
// compute prices/costs
// and also the logic to compute realizables

// if implemented would be wise to only accept baskets within baskets
// so that stock logic stays split

// also as a reminder
// ! below classes are a bad idea
// it would bring a lot of confusion in the views
// forcing us to pass articlesStore in places where not needed
// + additional type checks and casting

abstract class _Quantity {
  num get qt;
}

class _QtInStock extends _Quantity {
  @override
  final num qt;
  _QtInStock(this.qt) {
    assert(qt is double);
  }
}

class _QtBasketsRealizables extends _Quantity {
  @override
  final num qt;
  _QtBasketsRealizables(this.qt) {
    assert(qt is int);
  }
}

void main() {
  group(
      'failing test to show limits : today a basket cannot contain other baskets',
      () {
    test('min. qt requirements do not add up', () {
      final proxiesWorth =
          ArticleBasket.getProxiesListWithPriceAndCostArticleNotCreatedYetOnly(
        [
          _dummyLineRId1,
          _dummyLineBasketId2,
          _dummyLineBasketId4
        ], // mocking articlesStores.lines
        _dummyABasketInLineId2.proxies,
      );
      expect(proxiesWorth.totalPrice, 0); // 200 should be
      expect(proxiesWorth.totalCost, 0); // 160
    });
  });
}

// below contains ArticleRetail.dummy with calibreId: 1, id: 1, price: 100, cost: 80,
// we will reference this article eventually
final _dummyLineRId1 = ArticleCalibre.dummyRetail;

// below is an article basket line
final _dummyLineBasketId2 = ArticleCalibre.dummyBasket
    .copyWith(id: 2, articles: [_dummyABasketInLineId2]);

// ... which embeds a special proxy
final _dummyABasketInLineId2 = ArticleBasket.dummy.copyWith(
  calibreId: 2,
  id: 1,
  fullName: 'dummy baskets level #A',
  proxies: [_dummyProxyInLineId2],
);

// instead of pointing directly to an article retail (e.g. ArticleRetail.dummy)
// this proxy points to another article basket
final _dummyProxyInLineId2 = ProxyArticle.dummy.copyWith(
  calibreId: 2,
  articleId: 1,
  id: 1,
  proxyCalibreId: 4,
  proxyArticleId: 1,
  minimumUnitPerBasket: 2, //!
);

// here is this basket
final _dummyLineBasketId4 = ArticleCalibre.dummyBasket
    .copyWith(id: 4, articles: [_dummyABasketInLineId4]);

// ... which embeds a standard proxy
final _dummyABasketInLineId4 = ArticleBasket.dummy.copyWith(
  calibreId: 4,
  id: 1,
  fullName: 'dummy baskets level #B',
  proxies: [ProxyArticle.dummy],
);
