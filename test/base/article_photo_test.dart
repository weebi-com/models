import 'dart:convert';

import 'package:models_weebi/src/base_dummies/article_photo.dart';
import 'package:test/test.dart';

void main() {
  test('article_photo', () {
    final _json = ArticlePhotoDummy().toJson();
    final Map<String, dynamic> map = (json.decode(_json));
    expect(map['id'] == 1, isTrue);
    expect(map['calibreId'] == 1, isTrue);
    expect(map['path'] == 'path', isTrue);
    expect(map['source'] == 'unknown', isTrue);
  });
}
