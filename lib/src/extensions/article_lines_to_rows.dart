import 'package:models_weebi/base.dart';
import 'package:models_weebi/weebi_models.dart';

extension LineOfArticlesToRows<A extends ArticleAbstract>
    on List<ArticleLines<A>> {
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
      final line = this[i];
      cells.add(line.id);
      cells.add(line.title);
      cells.add(line.stockUnit);
      for (int ii = 0; ii < line.articles.length; ii++) {
        if (line.isBasket != null && line.isBasket!) {
          final articleBasket = (this[i].articles[ii] as ArticleBasket);

          cells.add(articleBasket.fullName);
          cells.add(articleBasket.weight);
          cells.add(articleBasket
              .getProxiesListWithPriceAndCost(this)
              .totalPrice); // price
          cells.add(
              articleBasket.getProxiesListWithPriceAndCost(this)..totalCost);
          cells.add(articleBasket.articleCode);
          cells.add(articleBasket.creationDate);
        } else {
          final article = this[i].articles[ii] as Article;
          cells.add(article.fullName);
          cells.add(article.weight);
          cells.add(article.price);
          cells.add(article.cost);
          cells.add(article.articleCode);
          cells.add(article.creationDate);
        }
      }
      rows.add(cells);
    }

    return rows;
  }
}
