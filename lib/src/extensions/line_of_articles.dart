import 'package:mobx/mobx.dart';
import 'package:models_weebi/base.dart';
import 'package:models_weebi/weebi_models.dart';

extension RealizableBaskets on Iterable<LineOfArticles> {
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
                article as ArticleWeebi, lot.minimumUnitPerBasket, 0.0);
            articleWrappers.add(wrapper);
          }
        }
      }
    }
    return articleWrappers;
  }
}

extension LinesSorted<P extends LineArticleAbstract> on ObservableList<P> {
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

extension LineOfArticlesToRows on List<LineOfArticles> {
  List<List<dynamic>> formatToRows() {
    List<List<dynamic>> rows = List<List<dynamic>>.empty(growable: true);
    List<String> lineHeader = List.empty(growable: true);
    lineHeader.add('id');
    lineHeader.add('titre');
    lineHeader.add('unit');
    lineHeader.add('nom');
    lineHeader.add('qt/unité');
    lineHeader.add('prix');
    lineHeader.add('cout');
    lineHeader.add('codebarre');
    lineHeader.add('date_creation');
    lineHeader.add('...');
    rows.add(lineHeader);

    for (int i = 0; i < length; i++) {
// row refer to each column of a row in csv file and rows refer to each row in a file
      List<dynamic> cells = List.empty(growable: true);
      final _line = this[i];
      cells.add(_line.id);
      cells.add(_line.title);
      cells.add(_line.stockUnit);
      for (int ii = 0; ii < _line.articles.length; ii++) {
        if (_line.isBasket != null && _line.isBasket!) {
          final _articleBasket =
              (this[i].articles[ii] as ArticleBasket).getPriceAndCost(this);
          cells.add(_articleBasket.fullName);
          cells.add(_articleBasket.weight);
          cells.add(_articleBasket.price);
          cells.add(_articleBasket.cost);
          cells.add(_articleBasket.articleCode);
          cells.add(_articleBasket.creationDate);
        } else {
          final _article = this[i].articles[ii] as ArticleWeebi;
          cells.add(_article.fullName);
          cells.add(_article.weight);
          cells.add(_article.price);
          cells.add(_article.cost);
          cells.add(_article.articleCode);
          cells.add(_article.creationDate);
        }
      }
      rows.add(cells);
    }

    return rows;
  }
}
