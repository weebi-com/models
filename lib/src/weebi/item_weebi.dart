import 'dart:convert';

import 'package:models_weebi/base.dart';
import 'package:models_weebi/src/weebi/article_basket.dart';
import 'package:models_weebi/src/weebi/article_weebi.dart';
import 'package:collection/collection.dart';
import 'package:models_weebi/src/weebi/proxy_article_worth.dart';

// items are deserialized in tickets with a single generic
// since a ticket can contain item with articleW and articleBasket
// we keep a single class itemWeebi to handle it

abstract class BasketAbstract<P extends ProxyArticleAbstract> {
  final List<P>? proxiesWorth;
  const BasketAbstract(this.proxiesWorth);
}

abstract class ItemInCartAbstract<A extends ArticleAbstract>
    extends ItemAbstract<A> implements BasketAbstract {
  @override
  final List<ProxyArticleWorth>? proxiesWorth;
  ItemInCartAbstract(A article, double quantity, {this.proxiesWorth})
      : super(article, quantity);

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

class ItemInCartAbstractDummy extends ItemInCartAbstract<ArticleDummy> {
  ItemInCartAbstractDummy() : super(ArticleDummy(), 2.0);
}

class ItemWeebi extends ItemInCartAbstract<ArticleWeebi> {
  ItemWeebi(final ArticleWeebi article, double quantity,
      {List<ProxyArticleWorth>? proxiesWorth})
      : super(
          article,
          quantity,
          proxiesWorth: proxiesWorth,
        );

  ItemWeebi copyWith(
      {ArticleWeebi? article,
      double? quantity,
      List<ProxyArticleWorth>? proxiesWorth}) {
    return ItemWeebi(
      article ?? this.article,
      quantity ?? this.quantity,
      proxiesWorth: proxiesWorth ?? this.proxiesWorth,
    );
  }

  bool get isBasket => proxiesWorth != null && proxiesWorth!.isNotEmpty;

  static final dummy = ItemWeebi(ArticleWeebi.dummy, 1.0);

  static final dummyBasket = ItemWeebi(ArticleWeebi.dummy, 1.0,
      proxiesWorth: <ProxyArticleWorth>[ProxyArticleWorth.dummy]);

  factory ItemWeebi.fromMap(Map<String, dynamic> map) {
    return ItemWeebi(
      map['article']['proxies'] == null
          ? ArticleWeebi.fromMap(map['article'])
          : (ArticleBasket.fromMap(map['article']) as ArticleWeebi),
      map['quantity'] == null ? 0.0 : (map['quantity'] as num).toDouble(),
      proxiesWorth: map['proxies_worth'] != null
          ? List<ProxyArticleWorth>.from(
              map['proxies_worth']?.map((x) => ProxyArticleWorth.fromMap(x)))
          : <ProxyArticleWorth>[],
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
        listEquals(other.proxiesWorth, proxiesWorth);
  }

  @override
  int get hashCode => quantity.hashCode;
}
