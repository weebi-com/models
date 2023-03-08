import 'dart:convert';

import 'package:models_weebi/base.dart';
import 'package:collection/collection.dart';
import 'package:models_weebi/src/models/article_creator_typedef.dart';
import 'package:models_weebi/src/models/item_cart_abstract.dart';
import 'package:models_weebi/weebi_models.dart';

// items are deserialized in tickets with a single generic
// since a ticket can contain item with articleW and articleBasket
// we keep a single class itemWeebi to handle it

extension AggregateItems on Iterable<ItemCartWeebi> {
  int get itemsTotalPrice => fold(0, (value, item) {
        if (item.isBasket) {
          final totalRaw = ((value +
                      (item.proxiesWorth as Iterable<ProxyArticleWorth>)
                          .totalPrice) *
                  item.quantity)
              .round();
          final totalFull = totalRaw -
              (item.article as ArticleBasket).discountAmountSalesOnly;
          return totalFull;
        } else {
          return (value + ((item.article as Article).price * item.quantity))
              .round();
        }
      });

  // -----
  // below spend and spendDeferred
  // -----
  int get itemsTotalCost => fold(0, (value, item) {
        if (item.isBasket) {
          return (value +
                  (item.proxiesWorth as Iterable<ProxyArticleWorth>).totalCost *
                      item.quantity)
              .round();
          // here I do not apply discount since this is a purchase
          // if needed consider creating an additional field discountAmountPurchaseOnly
        } else {
          return value +
              ((item.article as Article).cost * item.quantity).round();
        }
      });
}

class ItemCartWeebi<A extends ArticleAbstract> extends ItemInCartAbstract<A> {
  ItemCartWeebi(
    ArticleCreator<A> articleCreator,
    double quantity, {
    List<ProxyArticleWorth>? proxiesWorth,
  }) : super(
          articleCreator,
          quantity,
          proxiesWorth: proxiesWorth,
        );

  bool get isBasket => toMap()['article']['proxies'] != null;

  static final dummy = ItemCartWeebi(() => Article.dummy, 1.0);

  static final dummyBasket = ItemCartWeebi(() => Article.dummy, 1.0,
      proxiesWorth: <ProxyArticleWorth>[ProxyArticleWorth.dummy]);

  // I can play around with Article while ignoring its exact type :)
  int get totalPrice => (articlePrice * quantity).round();

  int get totalCost => (articleCost * quantity).round();

  int get articlePrice {
    A article = articleCreator();
    if (article.toMap()['proxies'] != null) {
      return proxiesWorth?.totalPrice ?? 0;
    } else {
      return (article as Article).price;
    }
  }

  int get articleCost {
    A article = articleCreator();
    if (article.toMap()['proxies'] != null) {
      return proxiesWorth?.totalCost ?? 0;
    } else {
      return (article as Article).cost;
    }
  }

  double getStockMovementForArticle<AA extends ArticleAbstract>(AA aSelected) {
    double stockMovement = 0.0;
    A aInItem = articleCreator();
    if (aSelected.lineId == aInItem.lineId && aSelected.id == aInItem.id) {
      stockMovement += quantity; // weight should not be included in article
    } else {
      if (isBasket == true) {
        if ((aInItem as ArticleBasket).proxies.any((proxy) =>
            proxy.proxyLineId == aSelected.lineId &&
            proxy.proxyArticleId == aSelected.id)) {
          for (final proxyOfArticleInItem in aInItem.proxies.where((proxy) =>
              proxy.proxyLineId == aSelected.lineId &&
              proxy.proxyArticleId == aSelected.id)) {
            stockMovement += quantity *
                proxyOfArticleInItem
                    .minimumUnitPerBasket; // weight should not be included in article
          }
        }
      }
    }
    return stockMovement;
  }

  double getStockMovementForLine(LineOfArticles line) {
    double stockMovement = 0.0;
    A aInItem = articleCreator();
    if (line.id == aInItem.lineId) {
      stockMovement +=
          quantity * aInItem.weight; // weight needed for line full stock
    } else {
      if (isBasket == true) {
        if ((aInItem as ArticleBasket)
            .proxies
            .any((p) => p.proxyLineId == line.id)) {
          for (final proxyOfArticleInItem
              in aInItem.proxies.where((p) => p.proxyLineId == line.id)) {
            stockMovement += quantity *
                proxyOfArticleInItem.minimumUnitPerBasket *
                proxyOfArticleInItem
                    .articleWeight; // weight needed for line full stock
          }
        }
      }
    }
    return stockMovement;
  }

  factory ItemCartWeebi.fromJson(String source) =>
      ItemCartWeebi.fromMap(json.decode(source));

  static fromMap(Map<String, dynamic> map) {
    return map['article']['proxies'] == null
        ? fromMapWeebi(map)
        : fromMapBasket(map);
  }

  static ItemCartWeebi<ArticleBasket> fromMapBasket(Map<String, dynamic> map) {
    return ItemCartWeebi<ArticleBasket>(
      () => ArticleBasket.fromMap(map['article']),
      map['quantity'] == null ? 0.0 : (map['quantity'] as num).toDouble(),
      proxiesWorth: map['proxies_worth'] != null
          ? List<ProxyArticleWorth>.from(
              map['proxies_worth']?.map((x) => ProxyArticleWorth.fromMap(x)))
          : <ProxyArticleWorth>[],
    );
  }

  static ItemCartWeebi<Article> fromMapWeebi(Map<String, dynamic> map) {
    return ItemCartWeebi<Article>(
      () => Article.fromMap(map['article']),
      map['quantity'] == null ? 0.0 : (map['quantity'] as num).toDouble(),
      proxiesWorth: [],
    );
  }

  ItemCartWeebi copyWith(
      {ArticleCreator<A>? articleCreator,
      double? quantity,
      List<ProxyArticleWorth>? proxiesWorth}) {
    return ItemCartWeebi<A>(
      articleCreator ?? this.articleCreator,
      quantity ?? this.quantity,
      proxiesWorth: proxiesWorth ?? this.proxiesWorth,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
    return other is ItemCartWeebi &&
        other.quantity == quantity &&
        other.article == article &&
        listEquals(other.proxiesWorth, proxiesWorth);
  }

  @override
  int get hashCode => quantity.hashCode;
}
