// import 'package:models_weebi/src/models/article_weebi.dart';
import 'package:models_weebi/weebi_models.dart';
import 'package:test/test.dart';

void main() {
  test('article Weebi', () {
    final json = ArticleRetail.dummy.toJson();
    final dummy = ArticleRetail.fromJson(json);
    // expect(dummy == ArticleWeebi.dummy, isTrue);
    expect(dummy.id == ArticleRetail.dummy.id, isTrue);
    expect(dummy.lineId == ArticleRetail.dummy.lineId, isTrue);
    expect(dummy.fullName == ArticleRetail.dummy.fullName, isTrue);
    expect(dummy.price == ArticleRetail.dummy.price, isTrue);
    expect(dummy.cost == ArticleRetail.dummy.cost, isTrue);
    expect(dummy.weight == ArticleRetail.dummy.weight, isTrue);
    expect(dummy.articleCode == ArticleRetail.dummy.articleCode, isTrue);
    expect(dummy.photo == ArticleRetail.dummy.photo, isTrue);
    expect(dummy.creationDate == ArticleRetail.dummy.creationDate, isTrue);
    expect(dummy.status == ArticleRetail.dummy.status, isTrue);
  });
}
