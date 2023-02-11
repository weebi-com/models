import 'package:models_weebi/src/models/articles_line.dart';
import 'package:test/test.dart';

void main() {
  test('line article weebi json', () {
    final json = LineOfArticles.dummy.toJson();
    final dummy = LineOfArticles.fromJson(json);
    // expect(dummy == ProductWeebi.dummy, isTrue);
    expect(dummy.id == LineOfArticles.dummy.id, isTrue);
    expect(dummy.status == LineOfArticles.dummy.status, isTrue);
    expect(dummy.creationDate == LineOfArticles.dummy.creationDate, isTrue);
  });
}
