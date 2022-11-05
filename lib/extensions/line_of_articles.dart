import 'package:models_weebi/src/models/article_basket.dart';
import 'package:models_weebi/src/models/article_weebi.dart';
import 'package:models_weebi/src/models/line_of_articles_w.dart';

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
