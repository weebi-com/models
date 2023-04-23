import 'package:mobx/mobx.dart';
import 'package:models_weebi/base.dart';
import 'package:models_weebi/weebi_models.dart';

extension RealizableBaskets on Iterable<ArticleLines> {
  Iterable<BasketWrapper> articleBasketWrapThemExt(
      ArticleBasket aBasket, DateTime start, DateTime end) {
    final articleWrappers = <BasketWrapper>[];
    if (isNotEmpty) {
      for (final lot in aBasket.proxies) {
        // a lot is a reference to an ArticleWeebi with a minimum qt needed to complete a basket
        // below matches lot refence to the ArticleW accordingly and add info
        if (any((line) => line.id == lot.proxyLineId)) {
          final line = firstWhere((line) => line.id == lot.proxyLineId);
          if (line.articles.any((a) =>
              a.lineId == lot.proxyLineId && a.id == lot.proxyArticleId)) {
            final article = line.articles.firstWhere((a) =>
                a.lineId == lot.proxyLineId && a.id == lot.proxyArticleId);
            final wrapper = BasketWrapper(
                article as Article, lot.minimumUnitPerBasket, 0.0);
            articleWrappers.add(wrapper);
          }
        }
      }
    }
    return articleWrappers;
  }
}

extension LinesSorted<P extends ArticleLineAbstract> on ObservableList<P> {
  ObservableList<P> sortedByTitle() {
    return ObservableList.of(
      this..sort((a, b) => a.title.compareTo(b.title)),
    );
  }

  ObservableList<P> sortedByTitleReversed() {
    return ObservableList.of(
      this..sort((a, b) => b.title.compareTo(a.title)),
    );
  }

  ObservableList<P> sortedById() {
    return ObservableList.of(
      this..sort((a, b) => a.id.compareTo(b.id)),
    );
  }

  ObservableList<P> sortedByIdReversed() {
    return ObservableList.of(
      this..sort((a, b) => b.id.compareTo(a.id)),
    );
  }
}
