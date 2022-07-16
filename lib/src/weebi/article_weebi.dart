import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:models_base/base.dart' show ArticleAbstract;
import 'package:models_base/utils.dart';

import 'package:models_weebi/src/weebi/lot_weebi.dart';

class ArticleWeebi extends ArticleAbstract {
  final String? shopUuid;
  List<LotWeebi>? lots;
  String? get shopId => shopUuid;
  ArticleWeebi(
      {required this.shopUuid,
      required int lineId,
      required int id,
      required String fullName,
      required int price,
      int cost = 0,
      double weight = 1.0,
      int? articleCode,
      String? photo = '',
      DateTime? creationDate,
      @observable bool status = false,
      this.lots})
      : super(
          lineId: lineId,
          id: id,
          fullName: fullName,
          price: price,
          cost: cost,
          weight: weight,
          articleCode: articleCode,
          photo: photo,
          creationDate: creationDate,
          status: status,
        );

  static final dummy = ArticleWeebi(
    shopUuid: 'shopUuid',
    lineId: 1,
    id: 1,
    fullName: 'dummy',
    price: 100,
    cost: 100,
    weight: 1,
    articleCode: 1,
    photo: 'photo',
    creationDate: WeebiDates.defaultDate,
    status: true,
    lots: [LotWeebi.dummy],
  );

  @override
  Map<String, dynamic> toMap() {
    return {
      'shopUuid': shopUuid,
      'lots': lots?.map((x) => x.toMap()).toList(),
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
        weight: map['weight'] == null ? 0.0 : (map['weight'] as num).toDouble(),
        articleCode: map['articleCode'] ?? 0,
        photo: map['photo'] ?? '',
        creationDate: map['creationDate'] == null
            ? WeebiDates.defaultDate
            : DateTime.parse(map['creationDate']),
        shopUuid: map['shopUuid'] ?? '',
        lots: map['lots'] != null
            ? List<LotWeebi>.from(map['lots']?.map((x) => LotWeebi.fromMap(x)))
            : [],
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
    bool? status,
    List<LotWeebi>? lots,
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
      status: status ?? this.status,
      lots: lots ?? this.lots,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    //final listEquals = const DeepCollectionEquality().equals;

    return other is ArticleWeebi &&
        other.shopUuid == shopUuid &&
        other.cost == cost &&
        other.price == price &&
        other.fullName == fullName &&
        other.id == id &&
        other.photo == photo;
  }

  @override
  int get hashCode => shopUuid.hashCode ^ lots.hashCode;
}
