import 'dart:convert';

import 'package:models_base/base.dart' show ProxyArticleAbstract;
import 'package:models_weebi/src/weebi/line_of_articles_w.dart';

class ProxyArticleWeebi extends ProxyArticleAbstract {
  final String? shopUuid; // distinguish shops data in backend db
  final double
      minimumQtPerBasket; // putting this here before inserting it into base

  ProxyArticleWeebi({
    required int lineId,
    required int articleId,
    required int id,
    required int proxyLineId,
    required int proxyArticleId,
    required this.shopUuid,
    required this.minimumQtPerBasket,
    bool status = true,
  }) : super(
          lineId: lineId,
          articleId: articleId,
          id: id,
          proxyLineId: proxyLineId,
          proxyArticleId: proxyArticleId,
          status: status,
        );

  static final dummy = ProxyArticleWeebi(
    lineId: 1,
    articleId: 1,
    id: 1,
    proxyLineId: 1,
    proxyArticleId: 1,
    minimumQtPerBasket: 1.0,
    shopUuid: '',
  );

  ProxyArticleWeebi copyWith({
    int? lineId,
    int? articleId,
    int? id,
    int? proxyLineId,
    int? proxyArticleId,
    bool? status,
    String? shopUuid,
    double? minimumQtPerBasket,
  }) {
    return ProxyArticleWeebi(
      lineId: lineId ?? this.lineId,
      articleId: articleId ?? this.articleId,
      id: id ?? this.id,
      proxyArticleId: proxyArticleId ?? this.proxyArticleId,
      proxyLineId: proxyLineId ?? this.proxyLineId,
      status: status ?? this.status,
      shopUuid: shopUuid ?? this.shopUuid,
      minimumQtPerBasket: minimumQtPerBasket ?? this.minimumQtPerBasket,
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
      'shopUuid': shopUuid,
      'status': status,
      'minimumUnitPerBasket': minimumQtPerBasket,
    };
  }

  factory ProxyArticleWeebi.fromMap(Map<String, dynamic> map) {
    return ProxyArticleWeebi(
      lineId: map['lineId'] == null
          ? map['productId'] as int
          : map['lineId'] as int,
      articleId: map['articleId'] as int,
      id: map['id'],
      proxyLineId: map['proxyLineId'],
      proxyArticleId: map['proxyArticleId'],
      shopUuid: map['shopUuid'],
      status: map['status'] ?? true,
      minimumQtPerBasket: map['minimumUnitPerBasket'],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory ProxyArticleWeebi.fromJson(String source) =>
      ProxyArticleWeebi.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProxyArticleWeebi &&
        other.shopUuid == shopUuid &&
        other.lineId == lineId &&
        other.articleId == articleId &&
        other.id == id &&
        other.proxyLineId == proxyLineId &&
        other.proxyArticleId == proxyArticleId &&
        minimumQtPerBasket == minimumQtPerBasket;
  }

  @override
  @override
  int get hashCode =>
      lineId.hashCode ^
      articleId.hashCode ^
      id.hashCode ^
      shopUuid.hashCode ^
      minimumQtPerBasket.hashCode ^
      proxyLineId.hashCode ^
      proxyArticleId.hashCode;
}

extension ProxiesCompute on List<ProxyArticleWeebi> {
  // articleBasket price must be computed
  int computeProxiesPrice(Iterable<LineOfArticles> lines) {
    final _prices = <int>[];
    if (isNotEmpty && lines.isNotEmpty) {
      for (final _line in lines) {
        for (final _lot in this) {
          if (_line.id == _lot.proxyLineId) {
            for (final _article in _line.articles) {
              if (_article.lineId == _lot.proxyLineId &&
                  _article.id == _lot.proxyArticleId) {
                _prices.add(_article.price);
              }
            }
          }
        }
      }
    }
    return _prices.fold(0, (prev, e) => prev + e);
  }

  // articleBasket price must be computed
  int computeProxiesCost(Iterable<LineOfArticles> lines) {
    final _costs = <int>[];
    if (isNotEmpty && lines.isNotEmpty) {
      for (final _line in lines) {
        for (final _lot in this) {
          if (_line.id == _lot.proxyLineId) {
            for (final _article in _line.articles) {
              if (_article.lineId == _lot.proxyLineId &&
                  _article.id == _lot.proxyArticleId) {
                _costs.add(_article.cost);
              }
            }
          }
        }
      }
    }
    return _costs.fold(0, (prev, e) => prev + e);
  }
}
