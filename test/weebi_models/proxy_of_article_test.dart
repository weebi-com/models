import 'package:models_weebi/src/weebi/proxy_article_weebi.dart';
import 'package:test/test.dart';

void main() {
  test('proxy of article weebi', () {
    final _json = ProxyArticleWeebi.dummy.toJson();
    final dummy = ProxyArticleWeebi.fromJson(_json);
    expect(dummy.lineId == ProxyArticleWeebi.dummy.lineId, isTrue);
    expect(dummy.articleId == ProxyArticleWeebi.dummy.articleId, isTrue);
    expect(dummy.id == ProxyArticleWeebi.dummy.id, isTrue);
    expect(dummy.proxyLineId == ProxyArticleWeebi.dummy.proxyLineId, isTrue);
    expect(
        dummy.proxyArticleId == ProxyArticleWeebi.dummy.proxyArticleId, isTrue);
    expect(dummy.status == ProxyArticleWeebi.dummy.status, isTrue);
  });
}
