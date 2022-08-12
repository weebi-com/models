import 'dart:convert';

import 'package:models_weebi/src/weebi/article_basket.dart';
import 'package:models_weebi/src/weebi/article_weebi.dart';
import 'package:models_weebi/src/weebi/lot_weebi.dart';
import 'package:models_base/base.dart' show ItemInCartAbstract;
import 'package:collection/collection.dart';

class ItemWeebi extends ItemInCartAbstract<ArticleWeebi, LotWeebi> {
  ItemWeebi(
    final ArticleWeebi article,
    List<LotWeebi>? lots, // ?
    double quantity,
  ) : super(
          article,
          lots,
          quantity,
        );

  static final dummy = ItemWeebi(ArticleWeebi.dummy, [LotWeebi.dummy], 1.0);

  factory ItemWeebi.fromMap(Map<String, dynamic> map) {
    return ItemWeebi(
      map['article']['lots'] == null
          ? ArticleWeebi.fromMap(map['article'])
          : ArticleBasket.fromMap(map['article']),
      map['lots'] != null
          ? List<LotWeebi>.from(map['lots']?.map((x) => LotWeebi.fromMap(x)))
          : <LotWeebi>[],
      map['quantity'] == null ? 0.0 : (map['quantity'] as num).toDouble(),
    );
  }

  factory ItemWeebi.fromJson(String source) =>
      ItemWeebi.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
    return other is ItemWeebi &&
        other.quantity == quantity &&
        other.article == article &&
        listEquals(other.lots, lots);
  }

  @override
  int get hashCode => quantity.hashCode;
}
