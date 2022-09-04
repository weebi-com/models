import 'dart:convert';

import 'package:models_weebi/src/weebi/article_basket.dart';
import 'package:models_weebi/src/weebi/article_weebi.dart';
import 'package:models_base/base.dart'
    show ProxyArticleWorth, ItemInCartAbstract;
import 'package:collection/collection.dart';

class ItemWeebi extends ItemInCartAbstract<ArticleWeebi, ProxyArticleWorth> {
  ItemWeebi(
    final ArticleWeebi article,
    List<ProxyArticleWorth>? proxiesWorth, // ?
    double quantity,
  ) : super(
          article,
          proxiesWorth,
          quantity,
        );

  static final dummy =
      ItemWeebi(ArticleWeebi.dummy, [ProxyArticleWorth.dummy], 1.0);

  factory ItemWeebi.fromMap(Map<String, dynamic> map) {
    return ItemWeebi(
      map['article']['proxies'] == null
          ? ArticleWeebi.fromMap(map['article'])
          : ArticleBasket.fromMapUnbuiltNoPriceNoCost(map['article']),
      map['proxies_worth'] != null
          ? List<ProxyArticleWorth>.from(
              map['proxies_worth']?.map((x) => ProxyArticleWorth.fromMap(x)))
          : <ProxyArticleWorth>[],
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
        listEquals(other.proxiesWorth, proxiesWorth);
  }

  @override
  int get hashCode => quantity.hashCode;
}
