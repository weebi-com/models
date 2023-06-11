import 'package:models_weebi/src/models/article_calibre.dart';
import 'package:test/test.dart';

void main() {
  test('line article weebi json', () {
    final json = ArticleCalibre.dummyRetail.toJson();
    final dummy = ArticleCalibre.fromJson(json);
    expect(dummy.id == ArticleCalibre.dummyRetail.id, isTrue);
    expect(dummy.status == ArticleCalibre.dummyRetail.status, isTrue);
    expect(
        dummy.creationDate == ArticleCalibre.dummyRetail.creationDate, isTrue);
  });
}
