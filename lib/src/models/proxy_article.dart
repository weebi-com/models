import 'dart:convert';

import 'package:models_base/base.dart' show ArticleProxyAbstract;
import 'package:models_weebi/src/models/article_retail.dart';
import 'package:models_weebi/src/models/article_calibre.dart';
import 'package:models_weebi/src/models/proxy_article_worth.dart';

mixin GimmeTheLoot on ArticleProxyAbstract {
  ProxyArticleWorth getProxyArticleWorth(
      Iterable<ArticleCalibre> linesInStore) {
    return ProxyArticleWorth.getPriceAndCost(
        linesInStore, this as ProxyArticle);
  }
}

class ProxyArticle extends ArticleProxyAbstract with GimmeTheLoot {
  final double
      minimumUnitPerBasket; // putting it here before inserting it into base
  final double articleWeight; // putting it here before inserting it into base

  ProxyArticle({
    required int calibreId,
    required int articleId,
    required int id,
    required int proxyCalibreId,
    required int proxyArticleId,
    required this.minimumUnitPerBasket,
    required this.articleWeight,
    bool status = true,
  }) : super(
          calibreId: calibreId,
          articleId: articleId,
          id: id,
          proxyCalibreId: proxyCalibreId,
          proxyArticleId: proxyArticleId,
          status: status,
        );

  static final dummy = ProxyArticle(
    calibreId: 2,
    articleId: 1,
    id: 1,
    proxyCalibreId: 1,
    proxyArticleId: 1,
    articleWeight: 1.0,
    minimumUnitPerBasket: 1.0,
  );

  ProxyArticle copyWith({
    int? calibreId,
    int? articleId,
    int? id,
    int? proxyCalibreId,
    int? proxyArticleId,
    bool? status,
    double? minimumUnitPerBasket,
    double? articleWeight,
  }) {
    return ProxyArticle(
      calibreId: calibreId ?? this.calibreId,
      articleId: articleId ?? this.articleId,
      id: id ?? this.id,
      proxyArticleId: proxyArticleId ?? this.proxyArticleId,
      proxyCalibreId: proxyCalibreId ?? this.proxyCalibreId,
      status: status ?? this.status,
      minimumUnitPerBasket: minimumUnitPerBasket ?? this.minimumUnitPerBasket,
      articleWeight: articleWeight ?? this.articleWeight,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'calibreId': calibreId,
      'articleId': articleId,
      'id': id,
      'proxyCalibreId': proxyCalibreId,
      'proxyArticleId': proxyArticleId,
      'status': status,
      'minimumUnitPerBasket': minimumUnitPerBasket,
      'articleWeight': articleWeight,
    };
  }

  factory ProxyArticle.fromMap(Map<String, dynamic> map) {
    return ProxyArticle(
      calibreId: map['calibreId'] != null
          ? map['calibreId'] as int
          : map['lineId'] != null
              ? map['lineId'] as int
              : map['productId'] as int,
      articleId: map['articleId'] as int,
      id: map['id'],
      proxyCalibreId: map['proxyCalibreId'] != null
          ? map['proxyCalibreId'] as int
          : map['proxyLineId'] != null
              ? map['proxyLineId'] as int
              : 0,
      proxyArticleId: map['proxyArticleId'],
      status: map['status'] ?? true,
      minimumUnitPerBasket: map['minimumUnitPerBasket'] == null
          ? 1.0
          : (map['minimumUnitPerBasket'] as num).toDouble(),
      articleWeight: map['articleWeight'] == null
          ? 1.0
          : (map['articleWeight'] as num).toDouble(),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory ProxyArticle.fromJson(String source) =>
      ProxyArticle.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProxyArticle &&
        other.calibreId == calibreId &&
        other.articleId == articleId &&
        other.id == id &&
        other.proxyCalibreId == proxyCalibreId &&
        other.proxyArticleId == proxyArticleId &&
        other.articleWeight == articleWeight &&
        minimumUnitPerBasket == minimumUnitPerBasket;
  }

  @override
  @override
  int get hashCode =>
      calibreId.hashCode ^
      articleId.hashCode ^
      id.hashCode ^
      minimumUnitPerBasket.hashCode ^
      proxyCalibreId.hashCode ^
      articleWeight.hashCode ^
      proxyArticleId.hashCode;

  int getPrice(Iterable<ArticleCalibre> linesInStore) {
    if (linesInStore.isNotEmpty) {
      for (final line in linesInStore) {
        if (line.isBasket == false && line.id == proxyCalibreId) {
          for (final article in line.articles) {
            if (article.calibreId == proxyCalibreId &&
                article.id == proxyArticleId) {
              return (article as ArticleRetail).price;
            }
          }
        }
      }
    }
    return 0;
  }

  int getCost(Iterable<ArticleCalibre> linesInStore) {
    if (linesInStore.isNotEmpty) {
      for (final line in linesInStore) {
        if (line.isBasket == false && line.id == proxyCalibreId) {
          for (final article in line.articles) {
            if (article.calibreId == proxyCalibreId &&
                article.id == proxyArticleId) {
              return (article as ArticleRetail).cost;
            }
          }
        }
      }
    }
    return 0;
  }
}
