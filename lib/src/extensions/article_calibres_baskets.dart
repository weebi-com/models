import 'package:models_weebi/weebi_models.dart';

extension RealizableBaskets on Iterable<ArticleCalibre> {
  Iterable<BasketWrapper> articleBasketWrapThemExt(
      ArticleBasket aBasket, DateTime start, DateTime end) {
    final articleWrappers = <BasketWrapper>[];
    if (isNotEmpty) {
      for (final proxy in aBasket.proxies) {
        // a proxy is a reference to an ArticleRetail with a minimum qt needed to complete a basket
        // below matches proxy refence to the ArticleW accordingly and add info
        if (any((line) => line.id == proxy.proxyCalibreId)) {
          final line = firstWhere((line) => line.id == proxy.proxyCalibreId);
          if (line.articles.any((a) =>
              a.calibreId == proxy.proxyCalibreId &&
              a.id == proxy.proxyArticleId)) {
            final article = line.articles.firstWhere((a) =>
                a.calibreId == proxy.proxyCalibreId &&
                a.id == proxy.proxyArticleId);
            final wrapper = BasketWrapper(
                article as ArticleRetail, proxy.minimumUnitPerBasket, 0.0);
            articleWrappers.add(wrapper);
          }
        }
      }
    }
    return articleWrappers;
  }
}
