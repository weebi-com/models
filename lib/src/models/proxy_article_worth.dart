import 'dart:convert';
import 'package:models_weebi/src/models/price_and_cost.dart';
import 'package:models_weebi/weebi_models.dart';

extension AggregateProxies on Iterable<ProxyArticleWorth> {
  // articleBasket price must be computed
  int get totalPrice {
    var worth = 0;
    for (final proxy in toSet()) {
      worth += (proxy.price * proxy.minimumUnitPerBasket).round();
    }
    return worth;
  }

  int get totalCost {
    var worth = 0;
    for (final proxy in toSet()) {
      worth += (proxy.cost * proxy.minimumUnitPerBasket).round();
    }
    return worth;
  }
}

class ProxyArticleWorth extends ProxyArticle implements Price, Cost {
  @override
  final num price;
  num get priceClean => num.parse(Price(price).toString());
  @override
  final num cost;
  num get costClean => num.parse(Cost(cost).toString());

  ProxyArticleWorth({
    required this.price,
    required this.cost,
    required double minimumUnitPerBasket,
    required int calibreId,
    required int articleId,
    required int id,
    required int proxyCalibreId,
    required int proxyArticleId,
    required double articleWeight,
    bool status = true,
  }) : super(
          calibreId: calibreId,
          articleId: articleId,
          id: id,
          proxyCalibreId: proxyCalibreId,
          proxyArticleId: proxyArticleId,
          status: status,
          minimumUnitPerBasket: minimumUnitPerBasket,
          articleWeight: articleWeight,
        );

  factory ProxyArticleWorth.getPriceAndCost(
      Iterable<ArticleCalibre> calibresInStore, ProxyArticle pNoPriceNoCost) {
    final price = pNoPriceNoCost.getPrice(calibresInStore);
    final cost = pNoPriceNoCost.getCost(calibresInStore);
    return ProxyArticleWorth(
        price: price,
        cost: cost,
        minimumUnitPerBasket: pNoPriceNoCost.minimumUnitPerBasket,
        calibreId: pNoPriceNoCost.calibreId,
        articleId: pNoPriceNoCost.articleId,
        id: pNoPriceNoCost.id,
        proxyCalibreId: pNoPriceNoCost.proxyCalibreId,
        articleWeight: pNoPriceNoCost.articleWeight,
        proxyArticleId: pNoPriceNoCost.proxyArticleId);
  }

  static get dummy => ProxyArticleWorth(
        price: 100,
        cost: 80,
        calibreId: 1,
        articleId: 1,
        id: 1,
        proxyCalibreId: 1,
        proxyArticleId: 1,
        minimumUnitPerBasket: 1.0,
        articleWeight: 1.0,
      );

  @override
  ProxyArticleWorth copyWith({
    int? price,
    int? cost,
    int? calibreId,
    int? articleId,
    int? id,
    int? proxyCalibreId,
    int? proxyArticleId,
    bool? status,
    double? minimumUnitPerBasket,
    double? articleWeight,
  }) {
    return ProxyArticleWorth(
      price: price ?? this.price,
      cost: cost ?? this.cost,
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
      calibreId: map['calibreId'] != null
          ? map['calibreId'] as int
          : map['lineId'] != null
              ? map['lineId'] as int
              : 0,
      articleId: map['articleId']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      proxyCalibreId: map['proxyCalibreId'] != null
          ? map['proxyCalibreId'] as int
          : map['proxyLineId'] != null
              ? map['proxyLineId'] as int
              : 0,
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
    return 'ArticleProxyWorth(calibreId: $calibreId, articleId: $articleId, price: $price, cost: $cost, minimumUnitPerBasket: $minimumUnitPerBasket)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProxyArticleWorth &&
        other.calibreId == calibreId &&
        other.articleId == articleId &&
        other.id == id &&
        other.price == price &&
        other.cost == cost &&
        other.articleWeight == articleWeight &&
        other.minimumUnitPerBasket == minimumUnitPerBasket;
  }

  @override
  int get hashCode {
    return calibreId.hashCode ^
        articleId.hashCode ^
        id.hashCode ^
        price.hashCode ^
        cost.hashCode ^
        articleWeight.hashCode ^
        minimumUnitPerBasket.hashCode;
  }
}
