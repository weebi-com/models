import 'package:models_weebi/src/weebi/line_of_articles_w.dart';
import 'package:test/test.dart';

void main() {
  test('line article weebi json', () {
    final _json = LineOfArticlesWeebi.dummy.toJson();
    final dummy = LineOfArticlesWeebi.fromJson(_json);
    // expect(dummy == ProductWeebi.dummy, isTrue);
    expect(dummy.id == LineOfArticlesWeebi.dummy.id, isTrue);
    expect(dummy.status == LineOfArticlesWeebi.dummy.status, isTrue);
    expect(
        dummy.creationDate == LineOfArticlesWeebi.dummy.creationDate, isTrue);
  });
}
