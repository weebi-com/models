import 'package:models_base/common.dart' show PhotoSource, StockUnit;
import 'package:models_weebi/weebi_models.dart'
    show ArticleCalibre, ArticlePhoto, ArticleRetail, Herder;

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

  List<ArticlePhoto> get extractArticlesPhotosFromParsedExcel {
    final photosList = <ArticlePhoto>[];
    for (var i = 0; i < length; i++) {
      final table = this[i];
      final newPhoto = ArticlePhoto(
        calibreId: table[0] != null
            ? table[0].runtimeType == int
                ? table[0]
                : int.tryParse(table[1])
            : 0,
        id: table[1] != null
            ? table[1].runtimeType == int
                ? table[1]
                : int.tryParse(table[1])
            : 0,
        path: table[3] != null ? table[3].toString().trim() : '',
        source: PhotoSource.file,
      );
      photosList.add(newPhoto);
    }
    return photosList;
  }

  List<ArticleCalibre<ArticleRetail>> extractArticlesCalibresFromParsedExcel(
      int nextLineId, String shopUuid) {
    final linesList = <ArticleCalibre<ArticleRetail>>[];
    var nextId = nextLineId; // just in case..
    for (var i = 0; i < length; i++) {
      final now = DateTime.now();
      final table = this[i];
      final newArticle = ArticleRetail(
        creationDate: now,
        calibreId: nextId,
        id: 1,
        fullName: table[0] != null ? table[0].toString().trim() : '',
        price: table[1] != null
            ? table[1].runtimeType == num
                ? table[1]
                : num.tryParse(table[1])
            : 0,
        cost: table[2] != null
            ? table[2].runtimeType == num
                ? table[2]
                : num.tryParse(table[2])
            : 0,
        weight: 1.0,
        articleCode: table[3] != null
            ? table[3].runtimeType == int
                ? table[3]
                : int.tryParse(table[3])
            : 0,
      );
      final newLine = ArticleCalibre<ArticleRetail>(
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

  // * TOconsider factorize in one function with a boolean isUpdate
  List<ArticleCalibre<ArticleRetail>>
      extractCalibresOfArticlesForUpdateFromParsedExcel(String shopUuid) {
    final linesList = <ArticleCalibre<ArticleRetail>>[];
    for (var i = 0; i < length; i++) // avoid header
    {
      final now = DateTime.now();
      final table = this[i];
      final newArticle = ArticleRetail(
        creationDate: now, // will be updated after if match
        calibreId: 0, // will be updated after if match
        id: 1,
        fullName: table[0] != null ? '${table[0]}' : '',
        price: table[1] != null
            ? table[1].runtimeType == num
                ? table[1]
                : num.tryParse(table[1])
            : 0,
        cost: table[2] != null
            ? table[2].runtimeType == num
                ? table[2]
                : num.tryParse(table[2])
            : 0,
        weight: 1.0,
        articleCode: table[3] != null
            ? table[3].runtimeType == int
                ? table[3]
                : int.tryParse(table[3])
            : 0,
      );
      final newLine = ArticleCalibre<ArticleRetail>(
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

  List<Herder> extractHerdersForUpdateFromDecodedRows(String shopUuid) {
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
