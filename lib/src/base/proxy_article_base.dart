import 'dart:convert';

abstract class ArticleProxyAbstract {
  final int calibreId;
  int get productId => calibreId;
  final int articleId;
  final int id;
  final bool status;
  final int proxyCalibreId;
  final int proxyArticleId;

  const ArticleProxyAbstract({
    required this.calibreId,
    required this.articleId,
    required this.id,
    required this.proxyCalibreId,
    required this.proxyArticleId,
    this.status = true,
  });

  String get text {
    return 'ArticleProxy $calibreId.$articleId.$id';
  }

  @override
  String toString() {
    return '''
ArticleProxy(
    calibreId: $calibreId,
    articleId: $articleId,
    id: $id,
    'proxyArticleId': $proxyArticleId,
    'proxyCalibreId': $proxyCalibreId,
    status: $status,
''';
  }

  Map<String, dynamic> toMap() {
    return {
      'calibreId': calibreId,
      'articleId': articleId,
      'id': id,
      'proxyArticleId': proxyArticleId,
      'proxyCalibreId': proxyCalibreId,
      'status': status,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ArticleProxyAbstract &&
        other.calibreId == calibreId &&
        other.articleId == articleId &&
        other.id == id &&
        other.proxyCalibreId == proxyCalibreId &&
        other.proxyArticleId == proxyArticleId &&
        other.status == status;
  }

  @override
  int get hashCode {
    return calibreId.hashCode ^
        articleId.hashCode ^
        id.hashCode ^
        status.hashCode ^
        proxyArticleId.hashCode & proxyCalibreId.hashCode;
  }
}
