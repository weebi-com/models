import 'package:models_base/common.dart';
import 'package:models_weebi/weebi_models.dart'
    show LineOfArticles, ArticleWeebi;

extension ImportArticles on List<List<dynamic>> {
  List<LineOfArticles> extractLinesOfArticlesFromParsedExcel(
      int nextLineId, String shopUuid) {
    final linesList = <LineOfArticles>[];
    var nextId = nextLineId; // just in case..
    for (var i = 1; i < length; i++) {
      final now = DateTime.now();
      final table = this[i];
      final _newArticle = ArticleWeebi(
        creationDate: now,
        updateDate: now,
        shopUuid: shopUuid,
        lineId: nextId,
        id: 1,
        fullName: table[0] != null ? '${table[0]}' : '',
        price: table[1] != null
            ? table[1].runtimeType == int
                ? table[1]
                : int.tryParse(table[1])
            : 0,
        cost: table[2] != null
            ? table[2].runtimeType == int
                ? table[2]
                : int.tryParse(table[2])
            : 0,
        weight: 1.0,
        articleCode: table[3] != null
            ? table[3].runtimeType == int
                ? table[3]
                : int.tryParse(table[3])
            : 0,
        photo: '',
      );
      final newLine = LineOfArticles(
        creationDate: now,
        updateDate: now,
        shopUuid: shopUuid,
        id: nextId,
        title: table[0] != null ? '${table[0]}' : '',
        status: true,
        statusUpdateDate: DateTime.now(),
        stockUnit: StockUnit.unit,
        categories: [''],
        photo: '',
        articles: [_newArticle],
      );
      linesList.add(newLine);
      nextId++;
    }
    return linesList;
  }
}
