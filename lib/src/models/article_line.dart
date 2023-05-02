import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:models_base/base.dart'
    show ArticleAbstract, ArticleLineAbstract;
import 'package:models_base/common.dart';
import 'package:models_base/utils.dart';
import 'package:models_weebi/src/extensions/string_no_accents.dart';
import 'package:models_weebi/src/models/article_basket.dart';
import 'package:models_weebi/src/models/article_retail.dart';
import 'package:collection/collection.dart';

// if (isBasket){ articles.length ==1 } !

class ArticleLine<A extends ArticleAbstract> extends ArticleLineAbstract<A> {
  // final String? shopUuid;
  // String? get shopId => shopUuid;

  final bool? isPalpable; // impalpable are only used for quickSpend,
  // usually quickSpends are for electricity/transport/credit stuff one cannot touch
  // it is also a pun since these articles yields no gain / no money perceived through them
  // finally easier to add this boolean rather than handle another set of Article class and to cast everywhere
  // * will create another class ArticleRaw or NoTag or NoPriceNoCost
  // to remove this field and deduce base on type
  final bool? isBasket;
  bool get isSingleArticle => articles.length <= 1;
  int get titleHash => title.withoutAccents.toLowerCase().trim().hashCode;
  @override
  String get photo => articles.isEmpty ? '' : articles.first.photo ?? '';
  ArticleLine({
    required int id,
    // required this.shopUuid,
    this.isPalpable =
        true, // ? doesn't this only mean quickspending ? with negative ids
    this.isBasket = false,
    required List<A> articles,
    List<String>? categories,
    required String title,
    StockUnit stockUnit = StockUnit.unit,
    @observable required bool status,
    DateTime? statusUpdateDate,
    required DateTime? creationDate,
    required DateTime? updateDate,
  }) : super(
          id: id,
          categories: categories,
          title: title,
          stockUnit: stockUnit,
          status: status,
          statusUpdateDate: statusUpdateDate,
          articles: articles,
          creationDate: creationDate,
          updateDate: updateDate,
        );

// use a mixin ?
  String get sharableText {
    final truc =
        StringBuffer(); //Consider removing this inherited from old  old stock management

    final sb = StringBuffer()
      ..writeln('# $id - $title')
      ..writeln('stock : ${truc.toString()}');
    return sb.toString();
  }

  static final dummy = ArticleLine<ArticleRetail>(
      // shopUuid: 'shopUuid',
      id: 1,
      articles: [ArticleRetail.dummy],
      title: 'dummy',
      status: true,
      creationDate: WeebiDates.defaultDate,
      updateDate: WeebiDates.defaultDate,
      isPalpable: true,
      isBasket: false);

  static final dummyBasket = ArticleLine<ArticleBasket>(
      id: 2,
      categories: null,
      title: 'truc bis',
      // shopUuid: '',
      creationDate: WeebiDates.defaultDate,
      updateDate: WeebiDates.defaultDate,
      stockUnit: StockUnit.unit,
      status: true,
      statusUpdateDate: DateTime.now(),
      articles: [ArticleBasket.dummy],
      isPalpable: true);

  @override
  Map<String, dynamic> toMap() {
    return {
      // 'shopUuid': shopUuid,
      'id': id,
      'isPalpable': isPalpable ?? true,
      'isBasket': isBasket ?? false,
      'title': title,
      'stockUnit': stockUnit.toString(),
      'photo': photo,
      'barcode': barcode ?? 0,
      'status': status,
      'statusUpdateDate': statusUpdateDate?.toIso8601String() ??
          WeebiDates.defaultDate.toIso8601String(),
      'articles': articles.map((x) => x.toMap()).toList(),
      'creationDate': creationDate?.toIso8601String() ??
          WeebiDates.defaultDate.toIso8601String(),
      'updateDate': creationDate?.toIso8601String() ??
          WeebiDates.defaultDate.toIso8601String(),
      'categories':
          categories == null ? <String>[] : categories!.map((e) => e).toList(),
    };
  }

  ArticleLine<ArticleRetail> fromMapArticleWeebi(Map<String, dynamic> map) {
    if ((map['isBasket'] ?? false) == false) {
      return ArticleLine.fromMap(map);
    } else {
      throw 'this is a basket';
    }
  }

  ArticleLine<ArticleBasket> fromMapArticleBasket(Map<String, dynamic> map) {
    if ((map['isBasket'] ?? false) == false) {
      throw 'this is not a basket';
    } else {
      return ArticleLine.fromMap(map);
    }
  }

  factory ArticleLine.fromMap(Map<String, dynamic> map) {
    return ArticleLine<A>(
      // shopUuid: map['shopUuid'] ?? '',
      id: map['id'],
      title: map['title'],
      isPalpable: map['isPalpable'] ?? true,
      isBasket: map['isBasket'] ?? false,
      stockUnit: StockUnit.tryParse(map['stockUnit'] ?? ''),
      creationDate: map['creationDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.parse(map['creationDate']),
      updateDate: map['updateDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.parse(map['updateDate']),
      status: map[
          'status'], // TODO consider removing since article has its own status
      statusUpdateDate: map['statusUpdateDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.parse(map['statusUpdateDate']),
      articles: map['articles'] == null || map['articles'] == []
          ? []
          : List<A>.from(map['articles'].map((x) {
              if (x['proxies'] == null) {
                return ArticleRetail.fromMap(x);
              } else {
                return ArticleBasket.fromMap(x);
              }
            })),
      categories: map["categories"] == null
          ? []
          : List<String>.from(map["categories"].map((x) => x)),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory ArticleLine.fromJson(String source) =>
      ArticleLine.fromMap(json.decode(source));

  ArticleLine<A> copyWith({
    String? shopUuid,
    int? id,
    String? title,
    bool? isPalpable,
    bool? isBasket,
    StockUnit? stockUnit,
    String? photo,
    bool? status,
    DateTime? statusUpdateDate,
    List<A>? articles,
    DateTime? creationDate,
    DateTime? updateDate,
    List<String>? categories,
  }) {
    return ArticleLine<A>(
      // shopUuid: shopUuid ?? this.shopUuid,
      id: id ?? this.id,
      isBasket: isBasket ?? this.isBasket,
      isPalpable: isPalpable ?? this.isPalpable,
      title: title ?? this.title,
      stockUnit: stockUnit ?? this.stockUnit,
      status: status ?? this.status,
      statusUpdateDate: statusUpdateDate ?? this.statusUpdateDate,
      articles: articles ??
          this.articles.map((e) => e).toList(), // a real copy, not a reference
      creationDate: creationDate ?? this.creationDate,
      updateDate: updateDate ?? this.updateDate,
      categories: categories ?? this.categories,
    );
  }

  @override
  int get hashCode => id.hashCode ^ isPalpable.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
    return other is ArticleLine &&
        // other.shopUuid == shopUuid &&
        other.id == id &&
        other.isPalpable == isPalpable &&
        listEquals(other.articles, articles);
  }
}
