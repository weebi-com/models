// import 'package:models_weebi/src/models/article_weebi.dart';
import 'package:models_weebi/weebi_models.dart';
import 'package:test/test.dart';

void main() {
  test('article retail', () {
    final json = ArticleRetail.dummy.toJson();
    final dummy = ArticleRetail.fromJson(json);

    expect(dummy.id == ArticleRetail.dummy.id, isTrue);
    expect(dummy.calibreId == ArticleRetail.dummy.calibreId, isTrue);
    expect(dummy.fullName == ArticleRetail.dummy.fullName, isTrue);
    expect(dummy.price == ArticleRetail.dummy.price, isTrue);
    expect(dummy.cost == ArticleRetail.dummy.cost, isTrue);
    expect(dummy.weight == ArticleRetail.dummy.weight, isTrue);
    expect(dummy.articleCode == ArticleRetail.dummy.articleCode, isTrue);
    expect(dummy.creationDate == ArticleRetail.dummy.creationDate, isTrue);
    expect(dummy.status == ArticleRetail.dummy.status, isTrue);
  });
}
