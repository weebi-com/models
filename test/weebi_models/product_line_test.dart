import 'package:models_weebi/src/weebi/line_article_w.dart';
import 'package:test/test.dart';

void main() {
  test('product weebi json', () {
    final _json = LineArticleWeebi.dummy.toJson();
    final dummy = LineArticleWeebi.fromJson(_json);
    // expect(dummy == ProductWeebi.dummy, isTrue);
    expect(dummy.id == LineArticleWeebi.dummy.id, isTrue);
    expect(dummy.status == LineArticleWeebi.dummy.status, isTrue);
    expect(dummy.creationDate == LineArticleWeebi.dummy.creationDate, isTrue);
  });
}
