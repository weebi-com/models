import 'package:models_weebi/src/models/article_line.dart';
import 'package:test/test.dart';

void main() {
  test('line article weebi json', () {
    final json = ArticleLine.dummy.toJson();
    final dummy = ArticleLine.fromJson(json);
    // expect(dummy == ProductWeebi.dummy, isTrue);
    expect(dummy.id == ArticleLine.dummy.id, isTrue);
    expect(dummy.status == ArticleLine.dummy.status, isTrue);
    expect(dummy.creationDate == ArticleLine.dummy.creationDate, isTrue);
  });
}
