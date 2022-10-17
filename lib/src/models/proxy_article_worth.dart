import 'dart:convert';
import 'package:models_weebi/src/models/price_and_cost.dart';
import 'package:models_weebi/weebi_models.dart';

extension AggregateProxies on Iterable<ProxyArticleWorth> {
  // articleBasket price must be computed
  int get totalPrice {
    var worth = 0;
    for (final _proxy in this) {
      worth += (_proxy.price * _proxy.minimumUnitPerBasket).round();
    }
    return worth;
  }

  int get totalCost {
    var worth = 0;
    for (final _proxy in this) {
      worth += (_proxy.cost * _proxy.minimumUnitPerBasket).round();
    }
    return worth;
  }
}

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
    required double articleWeight,
    bool status = true,
  }) : super(
          lineId: lineId,
          articleId: articleId,
          id: id,
          proxyLineId: proxyLineId,
          proxyArticleId: proxyArticleId,
          status: status,
          minimumUnitPerBasket: minimumUnitPerBasket,
          articleWeight: articleWeight,
        );

  factory ProxyArticleWorth.getPriceAndCost(
      Iterable<LineOfArticles> _linesInStore, ProxyArticle pNoPriceNoCost) {
    final int price = pNoPriceNoCost.getPrice(_linesInStore);
    final int cost = pNoPriceNoCost.getCost(_linesInStore);
    return ProxyArticleWorth(
        price: price,
        cost: cost,
        minimumUnitPerBasket: pNoPriceNoCost.minimumUnitPerBasket,
        lineId: pNoPriceNoCost.lineId,
        articleId: pNoPriceNoCost.articleId,
        id: pNoPriceNoCost.id,
        proxyLineId: pNoPriceNoCost.proxyLineId,
        articleWeight: pNoPriceNoCost.articleWeight,
        proxyArticleId: pNoPriceNoCost.proxyArticleId);
  }

  static get dummy => ProxyArticleWorth(
        price: 100,
        cost: 80,
        lineId: 1,
        articleId: 1,
        id: 1,
        proxyLineId: 1,
        proxyArticleId: 1,
        minimumUnitPerBasket: 1.0,
        articleWeight: 1.0,
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
    double? articleWeight,
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
      'price': price,
      'cost': cost,
      'minimumUnitPerBasket': minimumUnitPerBasket,
      'articleWeight': articleWeight,
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
        other.articleWeight == articleWeight &&
        other.minimumUnitPerBasket == minimumUnitPerBasket;
  }

  @override
  int get hashCode {
    return lineId.hashCode ^
        articleId.hashCode ^
        id.hashCode ^
        price.hashCode ^
        cost.hashCode ^
        articleWeight.hashCode ^
        minimumUnitPerBasket.hashCode;
  }
}
