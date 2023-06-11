import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:models_weebi/base.dart';
import 'package:models_weebi/common.dart';

import 'package:models_weebi/src/models/proxy_article_worth.dart';
import 'package:models_weebi/utils.dart';
import 'package:models_weebi/weebi_models.dart'
    show ProxyArticle, ArticleCalibre;
import 'package:collection/collection.dart';

class ArticleBasket extends ArticleAbstract {
  final List<ProxyArticle> proxies;
  // article price and cost can change
  // so proxies only save ref not price / nor cost which are fetched when invoked
  final int discountAmountSalesOnly;
  ArticleBasket({
    required int calibreId,
    required int id,
    required String fullName,
    double weight = 1.0,
    int? articleCode,
    String? photo = '',
    PhotoSource photoSource = PhotoSource.unknown,
    required DateTime creationDate,
    DateTime? updateDate,
    DateTime? statusUpdateDate,
    required this.proxies,
    @observable bool status = true,
    this.discountAmountSalesOnly = 0,
  }) : super(
          calibreId: calibreId,
          id: id,
          fullName: fullName,
          weight: weight,
          articleCode: articleCode,
          photo: photo ?? '',
          photoSource: photoSource,
          creationDate: creationDate,
          status: status,
        );

  Iterable<ProxyArticleWorth> getProxiesListWithPriceAndCost(
      Iterable<ArticleCalibre> calibres) {
    final proxiesWorth = <ProxyArticleWorth>[];
    for (final p in proxies) {
      final temp = p.getProxyArticleWorth(calibres);
      proxiesWorth.add(temp);
    }
    return proxiesWorth;
  }

  static Iterable<ProxyArticleWorth>
      getProxiesListWithPriceAndCostArticleNotCreatedYetOnly(
          Iterable<ArticleCalibre> calibres,
          Iterable<ProxyArticle> proxiesRaw) {
    final proxiesWorth = <ProxyArticleWorth>[];
    for (final p in proxiesRaw) {
      final temp = p.getProxyArticleWorth(calibres);
      proxiesWorth.add(temp);
    }
    return proxiesWorth;
  }

  static ArticleBasket get dummy => ArticleBasket(
        calibreId: 2,
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
        calibreId: map['calibreId'] != null
            ? map['calibreId'] as int
            : map['lineId'] != null
                ? map['lineId'] as int
                : map['productId'] as int,
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
      'calibreId': calibreId,
      'id': id,
      'discountAmount': discountAmountSalesOnly,
      'fullName': fullName,
      'weight': weight,
      'articleCode': articleCode ?? 0,
      'photo': photo,
      'creationDate': creationDate.toIso8601String(),
      'updateDate': updateDate.toIso8601String(),
      'statusUpdateDate': statusUpdateDate.toIso8601String(),
      'status': status,
    };
  }

  @override
  String toString() {
    return """
ArticleBasket(
  calibreId: $calibreId,
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

  ArticleBasket copyWith({
    int? calibreId,
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
      calibreId: calibreId ?? this.calibreId,
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
        other.calibreId == calibreId &&
        other.id == id &&
        other.photo == photo &&
        other.creationDate == creationDate &&
        other.updateDate == updateDate &&
        listEquals(other.proxies, proxies);
  }

  @override
  int get hashCode => id.hashCode ^ calibreId.hashCode;
}
