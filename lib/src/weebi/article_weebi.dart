import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:models_base/base.dart' show ArticleAbstract;
import 'package:models_weebi/src/weebi/lot_weebi.dart';

class ArticleWeebi extends ArticleAbstract {
  final String? shopUuid;
  List<LotWeebi>? lots;
  ArticleWeebi(
      {this.shopUuid,
      required int productId,
      required int id,
      required String fullName,
      required int price,
      int cost = 0,
      double weight = 1.0,
      int? articleCode,
      String? photo,
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
      'creationDate': creationDate!.toIso8601String(),
    };
  }

  factory ArticleWeebi.fromMap(Map<String, dynamic> map) {
    return ArticleWeebi(
      productId: map['productId'] as int,
      id: map['id'] as int,
      fullName: map['fullName'] as String,
      price: map['price'] as int,
      cost: map['cost'] as int,
      weight: (map['weight'] as num).toDouble(),
      articleCode: map['articleCode'] ?? 0,
      photo: map['photo'] ?? '',
      creationDate: DateTime.tryParse(map['creationDate']),
      shopUuid: map['shopUuid'] ?? '',
      lots: map['lots'] != null
          ? List<LotWeebi>.from(map['lots']?.map((x) => LotWeebi.fromMap(x)))
          : [],
    );
  }
  @override
  String toJson() => json.encode(toMap());

  factory ArticleWeebi.fromJson(String source) =>
      ArticleWeebi.fromMap(json.decode(source));
}
