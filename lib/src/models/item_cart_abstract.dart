import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:models_weebi/base.dart';
import 'package:models_weebi/src/models/article_creator_typedef.dart';
import 'package:models_weebi/src/models/basket_abstract.dart';
import 'package:models_weebi/src/models/proxy_article_worth.dart';

abstract class ItemInCartAbstract<A extends ArticleAbstract>
    extends ItemAbstract<A> implements BasketAbstract {
  @override
  final List<ProxyArticleWorth>? proxiesWorth;

  ArticleCreator<A> articleCreator;
  ItemInCartAbstract(this.articleCreator, double quantity, {proxiesWorth})
      : proxiesWorth = proxiesWorth ?? [],
        super(articleCreator(), quantity);

  @override
  String toString() => "Item($article,$proxiesWorth,$quantity)";

  @override
  Map<String, dynamic> toMap() {
    return {
      'article': article.toMap(),
      'quantity': quantity,
      'proxies_worth': proxiesWorth?.map((x) => x.toMap()).toList(),
    };
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is ItemInCartAbstract<A> &&
        other.article == article &&
        listEquals(other.proxiesWorth, proxiesWorth) &&
        other.quantity == quantity;
  }

  @override
  int get hashCode =>
      article.hashCode ^ proxiesWorth.hashCode ^ quantity.hashCode;
}
