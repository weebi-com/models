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
      required int productId,
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
          productId: productId,
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
    id: 1,
    productId: 1,
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
      'productId': productId,
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
        productId: map['productId'] as int,
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
}
