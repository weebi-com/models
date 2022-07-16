import 'dart:convert';

import 'package:models_weebi/src/weebi/article_weebi.dart';
import 'package:models_weebi/src/weebi/lot_weebi.dart';
import 'package:models_base/base.dart' show ItemAbstract;

class ItemWeebi extends ItemAbstract<ArticleWeebi, LotWeebi> {
  ItemWeebi(
    final ArticleWeebi product,
    List<LotWeebi>? lots,
    double quantity,
  ) : super(
          product,
          lots,
          quantity,
        );

  static final dummy = ItemWeebi(ArticleWeebi.dummy, [LotWeebi.dummy], 1.0);

  factory ItemWeebi.fromMap(Map<String, dynamic> map) {
    return ItemWeebi(
      ArticleWeebi.fromMap(map['article']),
      map['lots'] != null
          ? List<LotWeebi>.from(map['lots']?.map((x) => LotWeebi.fromMap(x)))
          : null,
      map['quantity'] == null ? 0.0 : (map['quantity'] as num).toDouble(),
    );
  }

  factory ItemWeebi.fromJson(String source) =>
      ItemWeebi.fromMap(json.decode(source));
}
