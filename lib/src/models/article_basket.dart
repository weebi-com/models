import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:models_weebi/base.dart';
import 'package:models_weebi/src/models/price_and_cost.dart';
import 'package:models_weebi/src/models/proxy_article.dart';
import 'package:models_weebi/src/models/proxy_article_worth.dart';
import 'package:models_weebi/utils.dart';
import 'package:models_weebi/weebi_models.dart'
    show ProxyArticle, LineOfArticles;
import 'package:collection/collection.dart';

class ArticleBasketWithPriceAndCost extends ArticleBasket
    implements PriceAndCostAbstract {
  @override
  final int price;
  @override
  final int cost;

  ArticleBasketWithPriceAndCost._({
    required this.price,
    required this.cost,
    required ArticleBasket aBasket,
  }) : super(
            lineId: aBasket.lineId,
            id: aBasket.id,
            fullName: aBasket.fullName,
            weight: aBasket.weight,
            articleCode: aBasket.articleCode,
            photo: aBasket.photo,
            creationDate: aBasket.creationDate,
            updateDate: aBasket.updateDate,
            status: aBasket.status,
            proxies: aBasket.proxies);

  factory ArticleBasketWithPriceAndCost.getPriceAndCost(
      Iterable<LineOfArticles> _linesInStore,
      ArticleBasket aBasketNoPriceNoCost) {
    final int price =
        aBasketNoPriceNoCost.proxies.computeProxiesPrice(_linesInStore);
    final int cost =
        aBasketNoPriceNoCost.proxies.computeProxiesCost(_linesInStore);
    return ArticleBasketWithPriceAndCost._(
        price: price, cost: cost, aBasket: aBasketNoPriceNoCost);
  }

  static final dummyWithPriceAndCost =
      ArticleBasketWithPriceAndCost.getPriceAndCost(
          [LineOfArticles.dummy, LineOfArticles.dummy], ArticleBasket.dummy);
}

mixin GetPriceAndCostMixin on ArticleAbstract {
  ArticleBasketWithPriceAndCost getPriceAndCost(
      Iterable<LineOfArticles> _linesInStore) {
    return ArticleBasketWithPriceAndCost.getPriceAndCost(
        _linesInStore, this as ArticleBasket);
  }
}

class ArticleBasket extends ArticleAbstract with GetPriceAndCostMixin {
  final List<ProxyArticle> proxies;
  // article price and cost can change
  // so proxes only save ref not price / nor cost which are fetched when invoked
  ArticleBasket({
    required int lineId,
    required int id,
    required String fullName,
    double weight = 1.0,
    int? articleCode,
    String? photo = '',
    required DateTime? creationDate,
    required DateTime? updateDate,
    @observable bool status = false,
    required this.proxies,
  }) : super(
          lineId: lineId,
          id: id,
          fullName: fullName,
          weight: weight,
          articleCode: articleCode,
          photo: photo,
          creationDate: creationDate,
          updateDate: updateDate,
          status: status,
        );

  Iterable<ProxyArticleWorth> getProxiesWithPriceAndCost(
      Iterable<LineOfArticles> lines) {
    final proxiesWorth = <ProxyArticleWorth>[];
    for (final p in proxies) {
      final temp = p.getProxyArticleWorth(lines);
      proxiesWorth.add(temp);
    }
    return proxiesWorth;
  }

  static get dummy => ArticleBasket(
        lineId: 1,
        id: 1,
        fullName: 'dummy',
        weight: 1,
        articleCode: 1,
        photo: 'photo',
        creationDate: WeebiDates.defaultDate,
        updateDate: WeebiDates.defaultDate,
        status: true,
        proxies: [ProxyArticle.dummy],
      );

  factory ArticleBasket.fromMap(Map<String, dynamic> map) {
    return ArticleBasket(
        lineId: map['lineId'] == null
            ? map['productId'] as int
            : map['lineId'] as int,
        id: map['id'] as int,
        fullName: map['fullName'] as String,
        weight: map['weight'] == null ? 0.0 : (map['weight'] as num).toDouble(),
        articleCode: map['articleCode'] ?? 0,
        photo: map['photo'] ?? '',
        creationDate: map['creationDate'] == null
            ? WeebiDates.defaultDate
            : DateTime.parse(map['creationDate']),
        updateDate: map['updateDate'] == null
            ? WeebiDates.defaultDate
            : DateTime.parse(map['updateDate']),
        proxies: map['proxies'] != null
            ? List<ProxyArticle>.from(
                map['proxies']?.map((x) => ProxyArticle.fromMap(x)))
            : [],
        status: map['status']);
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() {
    return {
      'proxies': proxies.map((x) => x.toMap()).toList(),
      'lineId': lineId,
      'id': id,
      'fullName': fullName,
      'weight': weight,
      'articleCode': articleCode ?? 0,
      'photo': photo ?? '',
      'creationDate': creationDate?.toIso8601String() ??
          WeebiDates.defaultDate.toIso8601String(),
      'updateDate': updateDate?.toIso8601String() ??
          WeebiDates.defaultDate.toIso8601String(),
      'status': status,
    };
  }

  @override
  String toString() {
    return """
ArticleBasket(
  lineId: $lineId,
  id: $id,
  fullName: '$fullName',
  creationDate: $creationDate,
  updateDate: $updateDate,
  weight: $weight,
  articleCode: $articleCode,
  photo: $photo,
  status: $status,
  proxies: $proxies,)""";
  }

  factory ArticleBasket.fromJson(String source) =>
      ArticleBasket.fromMap(json.decode(source));
  // factory ArticleBasket.fromJson(String source, List<LineOfArticles> lines) =>
  //     ArticleBasket.fromMap(json.decode(source), lines);

  ArticleBasket copyWith({
    int? lineId,
    int? id,
    String? fullName,
    double? weight,
    int? articleCode,
    String? photo,
    DateTime? creationDate,
    DateTime? updateDate,
    bool? status,
    List<ProxyArticle>? proxies,
  }) {
    return ArticleBasket(
      lineId: lineId ?? this.lineId,
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      weight: weight ?? this.weight,
      articleCode: articleCode ?? this.articleCode,
      photo: photo ?? this.photo,
      creationDate: creationDate ?? this.creationDate,
      updateDate: updateDate ?? this.updateDate,
      status: status ?? this.status,
      proxies: proxies ?? this.proxies,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
    return other is ArticleBasket &&
        other.fullName == fullName &&
        other.id == id &&
        other.photo == photo &&
        other.creationDate == creationDate &&
        other.updateDate == updateDate &&
        listEquals(other.proxies, proxies);
  }

  @override
  int get hashCode => id.hashCode;
}
