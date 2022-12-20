// import 'package:models_weebi/src/models/article_weebi.dart';
import 'package:models_weebi/weebi_models.dart';
import 'package:test/test.dart';

void main() {
  test('article Weebi', () {
    final _json = Article.dummy.toJson();
    final dummy = Article.fromJson(_json);
    // expect(dummy == ArticleWeebi.dummy, isTrue);
    expect(dummy.shopUuid == Article.dummy.shopUuid, isTrue);
    expect(dummy.id == Article.dummy.id, isTrue);
    expect(dummy.lineId == Article.dummy.lineId, isTrue);
    expect(dummy.fullName == Article.dummy.fullName, isTrue);
    expect(dummy.price == Article.dummy.price, isTrue);
    expect(dummy.cost == Article.dummy.cost, isTrue);
    expect(dummy.weight == Article.dummy.weight, isTrue);
    expect(dummy.articleCode == Article.dummy.articleCode, isTrue);
    expect(dummy.photo == Article.dummy.photo, isTrue);
    expect(dummy.creationDate == Article.dummy.creationDate, isTrue);
    expect(dummy.status == Article.dummy.status, isTrue);
  });
}
