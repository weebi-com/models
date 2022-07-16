import 'package:models_weebi/src/weebi/article_line_w.dart';
import 'package:test/test.dart';

void main() {
  test('product weebi json', () {
    final _json = ArticleLineWeebi.dummy.toJson();
    final dummy = ArticleLineWeebi.fromJson(_json);
    // expect(dummy == ProductWeebi.dummy, isTrue);
    expect(dummy.id == ArticleLineWeebi.dummy.id, isTrue);
    expect(dummy.status == ArticleLineWeebi.dummy.status, isTrue);
    expect(dummy.creationDate == ArticleLineWeebi.dummy.creationDate, isTrue);
  });
}
