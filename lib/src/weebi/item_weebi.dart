import 'dart:convert';

import 'package:models_weebi/src/weebi/article_basket.dart';
import 'package:models_weebi/src/weebi/article_weebi.dart';
import 'package:models_base/base.dart'
    show ProxyArticleWorth, ItemInCartAbstract;
import 'package:collection/collection.dart';

// items are deserialized in tickets with a single generic
// since a ticket can contain item with articleW and articleBasket
// we keep a single class itemWeebi to handle it

class ItemWeebi extends ItemInCartAbstract<ArticleWeebi, ProxyArticleWorth> {
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

  static final dummy = ItemWeebi(ArticleWeebi.dummy, 1.0);

  static final dummyBasket = ItemWeebi(ArticleWeebi.dummy, 1.0,
      proxiesWorth: [ProxyArticleWorth.dummy]);

  factory ItemWeebi.fromMap(Map<String, dynamic> map) {
    return ItemWeebi(
      map['article']['proxies'] == null
          ? ArticleWeebi.fromMap(map['article'])
          : ArticleBasket.fromMapUnbuiltNoPriceNoCost(map['article']),
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
