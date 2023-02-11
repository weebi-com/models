import 'package:models_weebi/src/models/proxy_article.dart';
import 'package:test/test.dart';

void main() {
  test('proxy of article weebi', () {
    final json = ProxyArticle.dummy.toJson();
    final dummy = ProxyArticle.fromJson(json);
    expect(dummy.lineId == ProxyArticle.dummy.lineId, isTrue);
    expect(dummy.articleId == ProxyArticle.dummy.articleId, isTrue);
    expect(dummy.id == ProxyArticle.dummy.id, isTrue);
    expect(dummy.proxyLineId == ProxyArticle.dummy.proxyLineId, isTrue);
    expect(dummy.proxyArticleId == ProxyArticle.dummy.proxyArticleId, isTrue);
    expect(dummy.status == ProxyArticle.dummy.status, isTrue);
  });
}
