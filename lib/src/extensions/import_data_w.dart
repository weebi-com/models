import 'package:models_base/common.dart' show StockUnit;
import 'package:models_weebi/weebi_models.dart'
    show Herder, ArticleLines, Article;

extension ImportData on List<List<dynamic>> {
  List<Herder> extractHerdersFromParsedExcel(
      int nextHerderId, String shopUuid) {
    final herdersList = <Herder>[];
    var nextId = nextHerderId; // just in case..
    print('extractHerdersFromParsedExcel.length $length');

    for (final row in this) {
      final now = DateTime.now();
      final herder = Herder(
        updateDate: now,
        status: true,
        statusUpdateDate: now,
        id: nextId,
        bidon: nextId,
        firstName: row[0] != null ? row[0].toString().trim() : '',
        lastName: row[1] != null ? row[1].toString().trim() : '',
        tel: row[2] != null ? row[2].toString().trim() : '',
        mail: row[3] != null ? row[3].toString().trim() : '',
        address: row[4] != null ? row[4].toString().trim() : '',
        isWoman: true, // the woman in me cannot be bothered really
        category: row[5] != null ? row[5].toString().trim() : '',
      );
      herdersList.add(herder);
      nextId++;
    }
    // print('herdersList.length ${herdersList.length}');
    return herdersList;
  }

  List<ArticleLines<Article>> extractArticlesLinesFromParsedExcel(
      int nextLineId, String shopUuid) {
    final linesList = <ArticleLines<Article>>[];
    var nextId = nextLineId; // just in case..
    for (var i = 0; i < length; i++) {
      final now = DateTime.now();
      final table = this[i];
      final newArticle = Article(
        creationDate: now,
        updateDate: now,
        lineId: nextId,
        id: 1,
        fullName: table[0] != null ? table[0].toString().trim() : '',
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
      final newLine = ArticleLines<Article>(
        creationDate: now,
        updateDate: now,
        id: nextId,
        title: table[0] != null ? table[0].toString().trim() : '',
        status: true,
        statusUpdateDate: DateTime.now(),
        stockUnit: StockUnit.unit,
        categories: [''],
        articles: [newArticle],
      );
      linesList.add(newLine);
      nextId++;
    }
    return linesList;
  }

  //TODO factorize in one function with a boolean isUpdate
  List<ArticleLines<Article>> extractLinesOfArticlesForUpdateFromParsedExcel(
      String shopUuid) {
    final linesList = <ArticleLines<Article>>[];
    for (var i = 0; i < length; i++) // avoid header
    {
      final now = DateTime.now();
      final table = this[i];
      final newArticle = Article(
        creationDate: now, // will be updated after if match
        updateDate: now,
        lineId: 0, // will be updated after if match
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
      final newLine = ArticleLines<Article>(
        creationDate: now,
        updateDate: now,
        id: 0,
        title: table[0] != null ? '${table[0]}' : '',
        status: true,
        statusUpdateDate: DateTime.now(),
        stockUnit: StockUnit.unit,
        categories: [''],
        articles: [newArticle],
      );
      linesList.add(newLine);
    }
    return linesList;
  }

  List<Herder> extractHerdersForUpdateFromParsedExcel(String shopUuid) {
    final herdersList = <Herder>[];
    for (var i = 0; i < length; i++) {
      final now = DateTime.now();
      final table = this[i];
      final herder = Herder(
        updateDate: now,
        status: true,
        statusUpdateDate: now,
        id: 0, // will be updated after if match
        bidon: 0, // will be updated after if match
        // shopId: shopUuid,
        firstName: table[0] != null ? table[0].toString().trim() : '',
        lastName: table[1] != null ? table[1].toString().trim() : '',
        tel: table[2] != null ? table[2].toString().trim() : '',
        mail: table[3] != null ? table[3].toString().trim() : '',
        address: table[4] != null ? table[4].toString().trim() : '',
        isWoman: true,
        category: table[5] != null ? table[5].toString().trim() : '',
      );
      herdersList.add(herder);
    }
    return herdersList;
  }
}
