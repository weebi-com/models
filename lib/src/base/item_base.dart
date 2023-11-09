import 'dart:convert';

import 'package:models_weebi/base.dart';

abstract class ItemAbstract<A extends ArticleAbstract> {
  final A article;
  double quantity;
  ItemAbstract(this.article, this.quantity);

  @override
  String toString() => "Item($article,$quantity)";

  Map<String, dynamic> toMap() =>
      {'article': article.toMap(), 'quantity': quantity};

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItemAbstract<A> &&
        other.article == article &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => article.hashCode ^ quantity.hashCode;
}
