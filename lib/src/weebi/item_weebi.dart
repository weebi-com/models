import 'dart:convert';

import 'package:models_weebi/src/weebi/article_weebi.dart';
import 'package:models_weebi/src/weebi/lot_weebi.dart';
import 'package:models_base/base.dart' show ItemAbstract;

class ItemWeebi extends ItemAbstract<ArticleWeebi, LotWeebi> {
  ItemWeebi(
    final ArticleWeebi article,
    List<LotWeebi>? lots,
    double quantity,
  ) : super(
          article,
          lots,
          quantity,
        );

  // @override
  // String toString() => "Item($article,$lots,$quantity)"

  factory ItemWeebi.fromMap(Map<String, dynamic> map) {
    return ItemWeebi(
      ArticleWeebi.fromMap(map['article']),
      map['lots'] != null
          ? List<LotWeebi>.from(map['lots']?.map((x) => LotWeebi.fromMap(x)))
          : null,
      map['quantity'] as double,
    );
  }

  factory ItemWeebi.fromJson(String source) =>
      ItemWeebi.fromMap(json.decode(source));
}
