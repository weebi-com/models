import 'package:models_weebi/weebi_models.dart';

extension RealizableBaskets on Iterable<ArticleCalibre> {
  Iterable<BasketWrapper> articleBasketWrapThemExt(
      ArticleBasket aBasket, DateTime start, DateTime end) {
    final articleWrappers = <BasketWrapper>[];
    if (isNotEmpty) {
      for (final proxy in aBasket.proxies) {
        // a proxy is a reference to an ArticleRetail with a minimum qt needed to complete a basket
        // below matches proxy refence to the ArticleW accordingly and add info
        if (any((c) => c.id == proxy.proxyCalibreId)) {
          final calibre =
              firstWhere((calibre) => calibre.id == proxy.proxyCalibreId);
          if (calibre.articles.any((a) =>
              a.calibreId == proxy.proxyCalibreId &&
              a.id == proxy.proxyArticleId)) {
            final article = calibre.articles.firstWhere((a) =>
                a.calibreId == proxy.proxyCalibreId &&
                a.id == proxy.proxyArticleId);
            if (article is ArticleRetail) {
              final wrapper =
                  BasketWrapper(article, proxy.minimumUnitPerBasket, 0.0);
              articleWrappers.add(wrapper);
            } else {
              print('article is not retail : ${article.toMap()}');
            }
          }
        }
      }
    }
    return articleWrappers;
  }
}
