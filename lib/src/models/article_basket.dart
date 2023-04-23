import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:models_weebi/base.dart';

import 'package:models_weebi/src/models/proxy_article_worth.dart';
import 'package:models_weebi/utils.dart';
import 'package:models_weebi/weebi_models.dart' show ProxyArticle, ArticleLines;
import 'package:collection/collection.dart';

class ArticleBasket extends ArticleAbstract {
  final List<ProxyArticle> proxies;
  DateTime? statusUpdateDate;
  // article price and cost can change
  // so proxies only save ref not price / nor cost which are fetched when invoked
  final int discountAmountSalesOnly;
  ArticleBasket({
    required int lineId,
    required int id,
    required String fullName,
    double weight = 1.0,
    int? articleCode,
    String? photo = '',
    required DateTime? creationDate,
    required DateTime? updateDate,
    required this.proxies,
    @observable bool status = true,
    this.statusUpdateDate,
    this.discountAmountSalesOnly = 0,
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

  Iterable<ProxyArticleWorth> getProxiesListWithPriceAndCost(
      Iterable<ArticleLines> lines) {
    final proxiesWorth = <ProxyArticleWorth>[];
    for (final p in proxies) {
      final temp = p.getProxyArticleWorth(lines);
      proxiesWorth.add(temp);
    }
    return proxiesWorth;
  }

  static Iterable<ProxyArticleWorth>
      getProxiesListWithPriceAndCostArticleNotCreatedYetOnly(
          Iterable<ArticleLines> lines, Iterable<ProxyArticle> proxiesRaw) {
    final proxiesWorth = <ProxyArticleWorth>[];
    for (final p in proxiesRaw) {
      final temp = p.getProxyArticleWorth(lines);
      proxiesWorth.add(temp);
    }
    return proxiesWorth;
  }

  static get dummy => ArticleBasket(
        lineId: 2,
        id: 1,
        fullName: 'dummy',
        weight: 1,
        articleCode: 1,
        photo: 'photo',
        creationDate: WeebiDates.defaultDate,
        updateDate: WeebiDates.defaultDate,
        status: true,
        proxies: [ProxyArticle.dummy],
        statusUpdateDate: WeebiDates.defaultDate,
        discountAmountSalesOnly: 0,
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
        discountAmountSalesOnly: map['discountAmount'] ?? 0,
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
        statusUpdateDate: map['statusUpdateDate'] == null
            ? WeebiDates.defaultDate
            : DateTime.parse(map['statusUpdateDate']),
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
      'discountAmount': discountAmountSalesOnly,
      'fullName': fullName,
      'weight': weight,
      'articleCode': articleCode ?? 0,
      'photo': photo ?? '',
      'creationDate': creationDate?.toIso8601String() ??
          WeebiDates.defaultDate.toIso8601String(),
      'updateDate': updateDate?.toIso8601String() ??
          WeebiDates.defaultDate.toIso8601String(),
      'statusUpdateDate': statusUpdateDate?.toIso8601String() ??
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
  weight: $weight,
  articleCode: $articleCode,
  discountAmount: $discountAmountSalesOnly,
  photo: $photo,
  creationDate: $creationDate,
  updateDate: $updateDate,
  statusUpdateDate: $statusUpdateDate,
  status: $status,
  proxies: $proxies,
  )""";
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
    int? discountAmountSalesOnly,
    String? photo,
    DateTime? creationDate,
    DateTime? updateDate,
    bool? status,
    List<ProxyArticle>? proxies,
    DateTime? statusUpdateDate,
  }) {
    return ArticleBasket(
      lineId: lineId ?? this.lineId,
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      weight: weight ?? this.weight,
      articleCode: articleCode ?? this.articleCode,
      discountAmountSalesOnly:
          discountAmountSalesOnly ?? this.discountAmountSalesOnly,
      photo: photo ?? this.photo,
      creationDate: creationDate ?? this.creationDate,
      updateDate: updateDate ?? this.updateDate,
      statusUpdateDate: statusUpdateDate ?? this.statusUpdateDate,
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
