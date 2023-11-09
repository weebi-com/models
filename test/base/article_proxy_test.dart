import 'dart:convert';

import 'package:models_weebi/src/base_dummies/article_proxy.dart';
import 'package:test/test.dart';

void main() {
  test('article proxy', () {
    final _json = ArticleProxyDummy().toJson();
    final Map<String, dynamic> map = (json.decode(_json));
    expect(map['calibreId'] == 1, isTrue);
    expect(map['articleId'] == 1, isTrue);
    expect(map['id'] == 1, isTrue);
    expect(map['status'] == true, isTrue);
    expect(map['proxyArticleId'] == 1, isTrue);
    expect(map['proxyCalibreId'] == 1, isTrue);
  });
}
