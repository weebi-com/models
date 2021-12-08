import 'package:models_weebi/src/weebi/article_weebi.dart';
import 'package:test/test.dart';

void main() {
  test('articleYobi', () {
    final _json = ArticleWeebi.dummy.toJson();
    final dummy = ArticleWeebi.fromJson(_json);
    expect(dummy == ArticleWeebi.dummy, isTrue);
  });
}
