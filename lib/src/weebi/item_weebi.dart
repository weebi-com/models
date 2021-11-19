import 'dart:convert';

import 'package:weebi_models/src/weebi/article_weebi.dart';
import 'package:weebi_models/src/weebi/lot_weebi.dart';
import 'package:models_base/base.dart';

class ItemWeebi extends Item<ArticleWeebi, LotWeebi> {
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
      map['quantity'],
    );
  }

  factory ItemWeebi.fromJson(String source) =>
      ItemWeebi.fromMap(json.decode(source));
}
