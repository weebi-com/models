import 'package:models_weebi/src/models/article_photo.dart';
import 'package:test/test.dart';

void main() {
  test('article photo json', () {
    final json = ArticlePhoto.dummy.toJson();
    final dummy = ArticlePhoto.fromJson(json);
    expect(dummy.calibreId == ArticlePhoto.dummy.calibreId, isTrue);
    expect(dummy.id == ArticlePhoto.dummy.id, isTrue);
    expect(dummy.path == ArticlePhoto.dummy.path, isTrue);
    expect(dummy.source == ArticlePhoto.dummy.source, isTrue);
  });
}
