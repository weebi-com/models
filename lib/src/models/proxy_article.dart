import 'dart:convert';

import 'package:models_base/base.dart' show ProxyArticleAbstract;
import 'package:models_weebi/src/models/article.dart';
import 'package:models_weebi/src/models/articles_line.dart';
import 'package:models_weebi/src/models/proxy_article_worth.dart';

extension ProxiesCompute on Iterable<ProxyArticle> {
  // articleBasket price must be computed
  int computeProxiesPrice(Iterable<LineOfArticles> lines) {
    final prices = <int>[];
    if (isNotEmpty && lines.isNotEmpty) {
      for (final line in lines.where((l) => l.isBasket == false)) {
        for (final proxy in this) {
          if (line.id == proxy.proxyLineId) {
            for (final article in line.articles) {
              if (article.lineId == proxy.proxyLineId &&
                  article.id == proxy.proxyArticleId) {
                prices.add((article as Article).price);
              }
            }
          }
        }
      }
    }
    return prices.fold(0, (prev, e) => prev + e);
  }

  // articleBasket price must be computed
  int computeProxiesCost(Iterable<LineOfArticles> lines) {
    final costs = <int>[];
    if (isNotEmpty && lines.isNotEmpty) {
      for (final line in lines) {
        for (final proxy in this) {
          if (line.id == proxy.proxyLineId && line.isBasket == false) {
            for (final article in line.articles) {
              if (article.lineId == proxy.proxyLineId &&
                  article.id == proxy.proxyArticleId) {
                costs.add((article as Article).cost);
              }
            }
          }
        }
      }
    }
    return costs.fold(0, (prev, e) => prev + e);
  }
}

mixin GimmeTheLoot on ProxyArticleAbstract {
  ProxyArticleWorth getProxyArticleWorth(
      Iterable<LineOfArticles> linesInStore) {
    return ProxyArticleWorth.getPriceAndCost(
        linesInStore, this as ProxyArticle);
  }
}

class ProxyArticle extends ProxyArticleAbstract with GimmeTheLoot {
  final double
      minimumUnitPerBasket; // putting it here before inserting it into base
  final double articleWeight; // putting it here before inserting it into base

  ProxyArticle({
    required int lineId,
    required int articleId,
    required int id,
    required int proxyLineId,
    required int proxyArticleId,
    required this.minimumUnitPerBasket,
    required this.articleWeight,
    bool status = true,
  }) : super(
          lineId: lineId,
          articleId: articleId,
          id: id,
          proxyLineId: proxyLineId,
          proxyArticleId: proxyArticleId,
          status: status,
        );

  static final dummy = ProxyArticle(
    lineId: 2,
    articleId: 1,
    id: 1,
    proxyLineId: 1,
    proxyArticleId: 1,
    articleWeight: 1.0,
    minimumUnitPerBasket: 1.0,
  );

  ProxyArticle copyWith({
    int? lineId,
    int? articleId,
    int? id,
    int? proxyLineId,
    int? proxyArticleId,
    bool? status,
    double? minimumUnitPerBasket,
    double? articleWeight,
  }) {
    return ProxyArticle(
      lineId: lineId ?? this.lineId,
      articleId: articleId ?? this.articleId,
      id: id ?? this.id,
      proxyArticleId: proxyArticleId ?? this.proxyArticleId,
      proxyLineId: proxyLineId ?? this.proxyLineId,
      status: status ?? this.status,
      minimumUnitPerBasket: minimumUnitPerBasket ?? this.minimumUnitPerBasket,
      articleWeight: articleWeight ?? this.articleWeight,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'lineId': lineId,
      'articleId': articleId,
      'id': id,
      'proxyLineId': proxyLineId,
      'proxyArticleId': proxyArticleId,
      'status': status,
      'minimumUnitPerBasket': minimumUnitPerBasket,
      'articleWeight': articleWeight,
    };
  }

  factory ProxyArticle.fromMap(Map<String, dynamic> map) {
    return ProxyArticle(
      lineId: map['lineId'] == null
          ? map['productId'] as int
          : map['lineId'] as int,
      articleId: map['articleId'] as int,
      id: map['id'],
      proxyLineId: map['proxyLineId'],
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
        other.lineId == lineId &&
        other.articleId == articleId &&
        other.id == id &&
        other.proxyLineId == proxyLineId &&
        other.proxyArticleId == proxyArticleId &&
        other.articleWeight == articleWeight &&
        minimumUnitPerBasket == minimumUnitPerBasket;
  }

  @override
  @override
  int get hashCode =>
      lineId.hashCode ^
      articleId.hashCode ^
      id.hashCode ^
      minimumUnitPerBasket.hashCode ^
      proxyLineId.hashCode ^
      articleWeight.hashCode ^
      proxyArticleId.hashCode;

  int getPrice(Iterable<LineOfArticles> linesInStore) {
    if (linesInStore.isNotEmpty) {
      for (final line in linesInStore) {
        if (line.isBasket == false && line.id == proxyLineId) {
          for (final article in line.articles) {
            if (article.lineId == proxyLineId && article.id == proxyArticleId) {
              return (article as Article).price;
            }
          }
        }
      }
    }
    return 0;
  }

  int getCost(Iterable<LineOfArticles> linesInStore) {
    if (linesInStore.isNotEmpty) {
      for (final line in linesInStore) {
        if (line.isBasket == false && line.id == proxyLineId) {
          for (final article in line.articles) {
            if (article.lineId == proxyLineId && article.id == proxyArticleId) {
              return (article as Article).cost;
            }
          }
        }
      }
    }
    return 0;
  }
}
