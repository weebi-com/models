import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:models_base/base.dart' show ArticleAbstract;
import 'package:models_base/utils.dart';
import 'package:models_weebi/src/models/price_and_cost.dart';
import 'package:models_weebi/src/models/proxy_article.dart';

class ArticleWeebi extends ArticleAbstract implements PriceAndCostAbstract {
  @override
  final int price;
  @override
  final int cost;
  final String? shopUuid;
  String? get shopId => shopUuid;
  ArticleWeebi(
      {this.shopUuid,
      required this.price,
      this.cost = 0,
      required int lineId,
      required int id,
      required String fullName,
      double weight = 1.0,
      int? articleCode,
      String? photo = '',
      required DateTime? creationDate,
      required DateTime? updateDate,
      @observable bool status = false})
      : super(
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

  static final dummy = ArticleWeebi(
    shopUuid: 'shopUuid',
    lineId: 1,
    id: 1,
    fullName: 'dummy',
    price: 100,
    cost: 80,
    weight: 1,
    articleCode: 1,
    photo: 'photo',
    creationDate: WeebiDates.defaultDate,
    updateDate: WeebiDates.defaultDate,
    status: true,
  );

  @override
  String toString() {
    return """
ArticleWeebi(
  lineId: $lineId,
  id: $id,
  fullName: '$fullName',
  price: $price,
  cost: $cost,
  creationDate: $creationDate,
  updateDate: $updateDate,
  weight: $weight,
  articleCode: $articleCode,
  photo: $photo,
  status: $status,
)
""";
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'shopUuid': shopUuid,
      'lineId': lineId,
      'id': id,
      'fullName': fullName,
      'price': price,
      'cost': cost,
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

  factory ArticleWeebi.fromMap(Map<String, dynamic> map) {
    return ArticleWeebi(
        lineId: map['lineId'] == null
            ? map['productId'] as int
            : map['lineId'] as int,
        id: map['id'] as int,
        fullName: map['fullName'] as String,
        price: map['price'] as int,
        cost: map['cost'] as int,
        weight: map['weight'] == null ? 1.0 : (map['weight'] as num).toDouble(),
        articleCode: map['articleCode'] ?? 0,
        photo: map['photo'] ?? '',
        creationDate: map['creationDate'] == null
            ? WeebiDates.defaultDate
            : DateTime.parse(map['creationDate']),
        updateDate: map['updateDate'] == null
            ? WeebiDates.defaultDate
            : DateTime.parse(map['updateDate']),
        shopUuid: map['shopUuid'] ?? '',
        status: map['status']);
  }

  @override
  String toJson() => json.encode(toMap());

  factory ArticleWeebi.fromJson(String source) =>
      ArticleWeebi.fromMap(json.decode(source));

  ArticleWeebi copyWith({
    String? shopUuid,
    int? lineId,
    int? id,
    String? fullName,
    int? price,
    int? cost,
    double? weight,
    int? articleCode,
    String? photo,
    DateTime? creationDate,
    DateTime? updateDate,
    bool? status,
    List<ProxyArticle>? proxies,
  }) {
    return ArticleWeebi(
      shopUuid: shopUuid ?? this.shopUuid,
      lineId: lineId ?? this.lineId,
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      price: price ?? this.price,
      cost: cost ?? this.cost,
      weight: weight ?? this.weight,
      articleCode: articleCode ?? this.articleCode,
      photo: photo ?? this.photo,
      creationDate: creationDate ?? this.creationDate,
      updateDate: updateDate ?? this.updateDate,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ArticleWeebi &&
        other.shopUuid == shopUuid &&
        other.cost == cost &&
        other.price == price &&
        other.fullName == fullName &&
        other.id == id &&
        other.photo == photo &&
        other.creationDate == creationDate &&
        other.updateDate == updateDate;
  }

  @override
  int get hashCode => shopUuid.hashCode;
}