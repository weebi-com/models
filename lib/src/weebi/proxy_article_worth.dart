import 'dart:convert';
import 'package:models_weebi/src/weebi/price_and_cost.dart';
import 'package:models_weebi/src/weebi/proxy_article.dart';
import 'package:models_weebi/weebi_models.dart';

class ProxyArticleWorth extends ProxyArticle implements PriceAndCostAbstract {
  @override
  final int price;
  @override
  final int cost;
  ProxyArticleWorth({
    required this.price,
    required this.cost,
    required double minimumUnitPerBasket,
    required int lineId,
    required int articleId,
    required int id,
    required int proxyLineId,
    required int proxyArticleId,
    bool status = true,
  }) : super(
            lineId: lineId,
            articleId: articleId,
            id: id,
            proxyLineId: proxyLineId,
            proxyArticleId: proxyArticleId,
            status: status,
            minimumUnitPerBasket: minimumUnitPerBasket);

  static get dummy => ProxyArticleWorth(
        price: 100,
        cost: 80,
        lineId: 1,
        articleId: 1,
        id: 1,
        proxyLineId: 1,
        proxyArticleId: 1,
        minimumUnitPerBasket: 1.0,
      );

  @override
  ProxyArticleWorth copyWith({
    int? price,
    int? cost,
    int? lineId,
    int? articleId,
    int? id,
    int? proxyLineId,
    int? proxyArticleId,
    bool? status,
    double? minimumUnitPerBasket,
  }) {
    return ProxyArticleWorth(
      price: price ?? this.price,
      cost: cost ?? this.cost,
      lineId: lineId ?? this.lineId,
      articleId: articleId ?? this.articleId,
      id: id ?? this.id,
      proxyArticleId: proxyArticleId ?? this.proxyArticleId,
      proxyLineId: proxyLineId ?? this.proxyLineId,
      status: status ?? this.status,
      minimumUnitPerBasket: minimumUnitPerBasket ?? this.minimumUnitPerBasket,
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
      'price': price,
      'cost': cost,
      'minimumUnitPerBasket': minimumUnitPerBasket,
    };
  }

  factory ProxyArticleWorth.fromMap(Map<String, dynamic> map) {
    return ProxyArticleWorth(
      price: map['price']?.toInt() ?? 0,
      cost: map['cost']?.toInt() ?? 0,
      lineId: map['lineId']?.toInt() ?? 0,
      articleId: map['articleId']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      proxyLineId: map['proxyLineId']?.toInt() ?? 0,
      proxyArticleId: map['proxyArticleId']?.toInt() ?? 0,
      minimumUnitPerBasket: map['minimumUnitPerBasket']?.toDouble() ?? 0.0,
    );
  }
  @override
  String toJson() => json.encode(toMap());

  factory ProxyArticleWorth.fromJson(String source) =>
      ProxyArticleWorth.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ArticleProxyWorth(lineId: $lineId, articleId: $articleId, price: $price, cost: $cost, minimumUnitPerBasket: $minimumUnitPerBasket)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProxyArticleWorth &&
        other.lineId == lineId &&
        other.articleId == articleId &&
        other.id == id &&
        other.price == price &&
        other.cost == cost &&
        other.minimumUnitPerBasket == minimumUnitPerBasket;
  }

  @override
  int get hashCode {
    return lineId.hashCode ^
        articleId.hashCode ^
        id.hashCode ^
        price.hashCode ^
        cost.hashCode ^
        minimumUnitPerBasket.hashCode;
  }
}
