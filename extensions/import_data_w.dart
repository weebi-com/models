import 'package:models_base/common.dart' show Address, StockUnit;
import 'package:models_weebi/weebi_models.dart'
    show HerderWeebi, Tristate, ContactWeebi, LineOfArticles, ArticleWeebi;

extension ImportData on List<List<dynamic>> {
  List<HerderWeebi> extractHerdersFromParsedExcel(int nextId, String shopUuid) {
    final herdersList = <HerderWeebi>[];
    var _nextId = nextId; // just in case..
    for (var i = 1; i < length; i++) {
      final now = DateTime.now();
      final table = this[i];
      final herder = HerderWeebi(
        updateDate: now,
        status: true,
        statusUpdateDate: now,
        id: _nextId,
        bidon: _nextId,
        shopId: shopUuid,
        firstName: table[0] != null ? table[0].toString().trim() : '',
        lastName: table[1] != null ? table[1].toString().trim() : '',
        tel: table[2] != null ? table[2].toString().trim() : '',
        mail: table[3] != null ? table[3].toString().trim() : '',
        address: table[4] != null ? table[4].toString().trim() : '',
        isWoman: table[5] == null
            ? false
            : table[5] == 'true'
                ? true
                : false,
        category: table[6] != null ? table[6].toString().trim() : '',
      );
      herdersList.add(herder);
      nextId++;
    }
    return herdersList;
  }

  List<ContactWeebi> extractContactsFromParsedExcel(
      List<List<dynamic>> data, int nextLineId, String shopUuid) {
    final contactsList = <ContactWeebi>[];
    var nextId = nextLineId; // just in case..
    for (var i = 1; i < data.length; i++) {
      final now = DateTime.now();
      final table = data[i];
      final _address = Address.addressEmpty;
      final newContact = ContactWeebi(
        updateDate: now,
        creationDate: now,
        status: true,
        statusUpdateDate: DateTime.now(),
        id: nextId,
        shopId: shopUuid,
        tel: '',
        mail: '',
        category: '',
        firstName: table[0] != null ? table[0].toString().trim() : '',
        lastName: table[1] != null ? table[1].toString().trim() : '',
        isWoman: table[5] != null && table[5] is String
            ? Tristate.tryParse(table[5])
            : Tristate.unknown,
        address: _address, // make this a list
      );
      contactsList.add(newContact);
      nextId++;
    }
    return contactsList;
  }

  List<LineOfArticles<ArticleWeebi>> extractLinesOfArticlesFromParsedExcel(
      int nextLineId, String shopUuid) {
    final linesList = <LineOfArticles<ArticleWeebi>>[];
    var nextId = nextLineId; // just in case..
    for (var i = 1; i < length; i++) // avoid header
    {
      final now = DateTime.now();
      final table = this[i];
      final _newArticle = ArticleWeebi(
        creationDate: now,
        updateDate: now,
        shopUuid: shopUuid,
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
      final newLine = LineOfArticles<ArticleWeebi>(
        creationDate: now,
        updateDate: now,
        shopUuid: shopUuid,
        id: nextId,
        title: table[0] != null ? table[0].toString().trim() : '',
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

  List<LineOfArticles<ArticleWeebi>>
      extractLinesOfArticlesForUpdateFromParsedExcel(String shopUuid) {
    final linesList = <LineOfArticles<ArticleWeebi>>[];
    for (var i = 1; i < length; i++) // avoid header
    {
      final now = DateTime.now();
      final table = this[i];
      final _newArticle = ArticleWeebi(
        creationDate: now, // will be updated after if match
        updateDate: now,
        shopUuid: shopUuid,
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
      final newLine = LineOfArticles<ArticleWeebi>(
        creationDate: now,
        updateDate: now,
        shopUuid: shopUuid,
        id: 0,
        title: table[0] != null ? '${table[0]}' : '',
        status: true,
        statusUpdateDate: DateTime.now(),
        stockUnit: StockUnit.unit,
        categories: [''],
        photo: '',
        articles: [_newArticle],
      );
      linesList.add(newLine);
    }
    return linesList;
  }

  List<HerderWeebi> extractHerdersForUpdateFromParsedExcel(String shopUuid) {
    final herdersList = <HerderWeebi>[];
    for (var i = 1; i < length; i++) {
      final now = DateTime.now();
      final table = this[i];
      final herder = HerderWeebi(
        updateDate: now,
        status: true,
        statusUpdateDate: now,
        id: 0, // will be updated after if match
        bidon: 0, // will be updated after if match
        shopId: shopUuid,
        firstName: table[0] != null ? table[0].toString().trim() : '',
        lastName: table[1] != null ? table[1].toString().trim() : '',
        tel: table[2] != null ? table[2].toString().trim() : '',
        mail: table[3] != null ? table[3].toString().trim() : '',
        address: table[4] != null ? table[4].toString().trim() : '',
        isWoman: table[5] == null
            ? false
            : table[5] == 'true'
                ? true
                : false,
        category: table[6] != null ? table[6].toString().trim() : '',
      );
      herdersList.add(herder);
    }
    return herdersList;
  }
}