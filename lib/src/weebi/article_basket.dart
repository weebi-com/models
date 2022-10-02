import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:models_weebi/utils.dart';
import 'package:models_weebi/weebi_models.dart'
    show ProxyArticleWeebi, ArticleWeebi, LineOfArticles;
import 'package:collection/collection.dart';
import 'package:models_weebi/src/weebi/proxy_article_weebi.dart';

class ArticleBasket extends ArticleWeebi {
  final List<ProxyArticleWeebi> proxies;
  // article price and cost can change
  // so proxes only save ref not price / nor cost which are fetched when invoked
  ArticleBasket.unbuiltNoPriceNoCost({
    required String? shopUuid,
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
          shopUuid: shopUuid,
          lineId: lineId,
          id: id,
          price: -1,
          cost: -1,
          fullName: fullName,
          weight: weight,
          articleCode: articleCode,
          photo: photo,
          creationDate: creationDate,
          updateDate: updateDate,
          status: status,
        );

  // * seems costly to check that no diff occured since initial fetch price/cost
  // keeping it dynami for now
  // for (final newLine in _linesInStore) {
  //   if (_oldLines.contains(newLine) == false) {
  //     _oldLines.add(newLine);
  //   }
  // }
  factory ArticleBasket.gettingPriceAndCost(
      Iterable<LineOfArticles> _linesInStore,
      ArticleBasket aBasketNoPriceNoCost) {
    final int price =
        aBasketNoPriceNoCost.proxies.computeProxiesPrice(_linesInStore);
    final int cost =
        aBasketNoPriceNoCost.proxies.computeProxiesCost(_linesInStore);
    return ArticleBasket._withPriceAndCost(
        shopUuid: aBasketNoPriceNoCost.shopUuid,
        lineId: aBasketNoPriceNoCost.lineId,
        id: aBasketNoPriceNoCost.id,
        price: price,
        cost: cost,
        fullName: aBasketNoPriceNoCost.fullName,
        creationDate: aBasketNoPriceNoCost.creationDate,
        updateDate: aBasketNoPriceNoCost.updateDate,
        proxies: aBasketNoPriceNoCost.proxies);
  }

  ArticleBasket._withPriceAndCost({
    required String? shopUuid,
    required int lineId,
    required int id,
    required int price,
    required int cost,
    required String fullName,
    double weight = 1.0,
    int? articleCode,
    String? photo = '',
    required DateTime? creationDate,
    required DateTime? updateDate,
    @observable bool status = false,
    required this.proxies,
  }) : super(
          shopUuid: shopUuid,
          lineId: lineId,
          id: id,
          price: price,
          cost: cost,
          fullName: fullName,
          weight: weight,
          articleCode: articleCode,
          photo: photo,
          creationDate: creationDate,
          updateDate: updateDate,
          status: status,
        );

  static final dummyNoPriceNoCost = ArticleBasket.unbuiltNoPriceNoCost(
    shopUuid: 'shopUuid',
    lineId: 1,
    id: 1,
    fullName: 'dummy',
    weight: 1,
    articleCode: 1,
    photo: 'photo',
    creationDate: WeebiDates.defaultDate,
    updateDate: WeebiDates.defaultDate,
    status: true,
    proxies: [ProxyArticleWeebi.dummy],
  );
  static final dummyWithPriceAndCost = ArticleBasket.gettingPriceAndCost(
      [LineOfArticles.dummy, LineOfArticles.dummy], dummyNoPriceNoCost);

  @override
  Map<String, dynamic> toMap() {
    return {
      'shopUuid': shopUuid,
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

  factory ArticleBasket.fromMapUnbuiltNoPriceNoCost(Map<String, dynamic> map) {
    return ArticleBasket.unbuiltNoPriceNoCost(
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
        shopUuid: map['shopUuid'] ?? '',
        proxies: map['proxies'] != null
            ? List<ProxyArticleWeebi>.from(
                map['proxies']?.map((x) => ProxyArticleWeebi.fromMap(x)))
            : [],
        status: map['status']);
  }

  factory ArticleBasket.fromMap(Map<String, dynamic> map) {
    return ArticleBasket.unbuiltNoPriceNoCost(
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
        shopUuid: map['shopUuid'] ?? '',
        proxies: map['proxies'] != null
            ? List<ProxyArticleWeebi>.from(
                map['proxies']?.map((x) => ProxyArticleWeebi.fromMap(x)))
            : [],
        status: map['status']);
  }

  // factory ArticleBasket.fromMap(
  //   Map<String, dynamic> map,
  //   Iterable<LineOfArticles> lines,
  // ) {
  //   return ArticleBasket.gettingPriceAndCost(lines,
  //       lineId: map['lineId'] == null
  //           ? map['productId'] as int
  //           : map['lineId'] as int,
  //       id: map['id'] as int,
  //       fullName: map['fullName'] as String,
  //       weight: map['weight'] == null ? 0.0 : (map['weight'] as num).toDouble(),
  //       articleCode: map['articleCode'] ?? 0,
  //       photo: map['photo'] ?? '',
  //       creationDate: map['creationDate'] == null
  //           ? WeebiDates.defaultDate
  //           : DateTime.parse(map['creationDate']),
  //       updateDate: map['updateDate'] == null
  //           ? WeebiDates.defaultDate
  //           : DateTime.parse(map['updateDate']),
  //       shopUuid: map['shopUuid'] ?? '',
  //       proxies: map['proxies'] != null
  //           ? List<ProxyArticleWeebi>.from(
  //               map['proxies']?.map((x) => ProxyArticleWeebi.fromMap(x)))
  //           : [],
  //       status: map['status']);
  // }

  @override
  String toJson() => json.encode(toMap());

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
  proxies: $proxies,
)
""";
  }

  factory ArticleBasket.fromJson(String source) =>
      ArticleBasket.fromMap(json.decode(source));
  // factory ArticleBasket.fromJson(String source, List<LineOfArticles> lines) =>
  //     ArticleBasket.fromMap(json.decode(source), lines);

  @override
  ArticleBasket copyWith({
    Iterable<LineOfArticles>? newLines,
    String? shopUuid,
    int? lineId,
    int? id,
    String? fullName,
    int? price, // TODO consider removing them from base models and using mixin
    int? cost,
    double? weight,
    int? articleCode,
    String? photo,
    DateTime? creationDate,
    DateTime? updateDate,
    bool? status,
    List<ProxyArticleWeebi>? proxies,
  }) {
    final int price = proxies != null && newLines != null
        ? proxies.computeProxiesPrice(newLines)
        : -1;
    final int cost = proxies != null && newLines != null
        ? proxies.computeProxiesCost(newLines)
        : -1;

    return ArticleBasket._withPriceAndCost(
      shopUuid: shopUuid ?? this.shopUuid,
      lineId: lineId ?? this.lineId,
      id: id ?? this.id,
      price: price == -1 ? this.price : price,
      cost: cost == -1 ? this.cost : cost,
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
        other.shopUuid == shopUuid &&
        other.cost == cost &&
        other.price == price &&
        other.fullName == fullName &&
        other.id == id &&
        other.photo == photo &&
        other.creationDate == creationDate &&
        other.updateDate == updateDate &&
        listEquals(other.proxies, proxies);
  }

  @override
  int get hashCode => shopUuid.hashCode;
}
