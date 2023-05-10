import 'package:models_weebi/weebi_models.dart';

extension RealizableBaskets on Iterable<ArticleLine> {
  Iterable<BasketWrapper> articleBasketWrapThemExt(
      ArticleBasket aBasket, DateTime start, DateTime end) {
    final articleWrappers = <BasketWrapper>[];
    if (isNotEmpty) {
      for (final lot in aBasket.proxies) {
        // a lot is a reference to an ArticleRetail with a minimum qt needed to complete a basket
        // below matches lot refence to the ArticleW accordingly and add info
        if (any((line) => line.id == lot.proxyLineId)) {
          final line = firstWhere((line) => line.id == lot.proxyLineId);
          if (line.articles.any((a) =>
              a.lineId == lot.proxyLineId && a.id == lot.proxyArticleId)) {
            final article = line.articles.firstWhere((a) =>
                a.lineId == lot.proxyLineId && a.id == lot.proxyArticleId);
            final wrapper = BasketWrapper(
                article as ArticleRetail, lot.minimumUnitPerBasket, 0.0);
            articleWrappers.add(wrapper);
          }
        }
      }
    }
    return articleWrappers;
  }
}
