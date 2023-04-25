import 'package:models_weebi/src/models/articles_lines.dart';
import 'package:test/test.dart';

void main() {
  test('line article weebi json', () {
    final json = ArticleLines.dummy.toJson();
    final dummy = ArticleLines.fromJson(json);
    // expect(dummy == ProductWeebi.dummy, isTrue);
    expect(dummy.id == ArticleLines.dummy.id, isTrue);
    expect(dummy.status == ArticleLines.dummy.status, isTrue);
    expect(dummy.creationDate == ArticleLines.dummy.creationDate, isTrue);
  });
}
