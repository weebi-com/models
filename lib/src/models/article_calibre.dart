import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:models_base/base.dart'
    show ArticleAbstract, ArticleCalibreAbstract;
import 'package:models_base/common.dart';
import 'package:models_weebi/utils.dart';
import 'package:models_weebi/src/dummies/confitures.dart';
import 'package:models_weebi/src/extensions/string_no_accents.dart';
import 'package:models_weebi/src/models/article_basket.dart';
import 'package:models_weebi/src/models/article_retail.dart';
import 'package:collection/collection.dart';

// if (isBasket){ articles.length ==1 } !

class ArticleCalibre<A extends ArticleAbstract>
    extends ArticleCalibreAbstract<A> {
  // final String? shopUuid;
  // String? get shopId => shopUuid;

  final bool? isPalpable; // impalpable are only used for quickSpend,
  // usually quickSpends are for electricity/transport/credit stuff one cannot touch
  // it is also a pun since these articles yields no gain / no money perceived through them
  // finally easier to add this boolean rather than handle another set of Article class and to cast everywhere
  // * will create another class ArticleRaw or NoTag or NoPriceNoCost
  // to remove this field and deduce base on type
  bool isBasket;
  bool get isSingleArticle => articles.length <= 1;
  bool get isNotQuickSpend => (isPalpable ?? true);
  String get nameLine => title;
  int get titleHash => title.withoutAccents.toLowerCase().trim().hashCode;

  ArticleCalibre({
    required int id,
    this.isPalpable =
        true, // ? today this only mean quickspending i.e. with negative ids
    required List<A> articles,
    List<String>? categories,
    required String title,
    StockUnit stockUnit = StockUnit.unit,
    @observable required bool status,
    DateTime? statusUpdateDate,
    required DateTime? creationDate,
    DateTime? updateDate,
  })  : isBasket = articles.isNotEmpty && articles.first is ArticleBasket,
        super(
          id: id,
          categories: categories,
          title: title,
          stockUnit: stockUnit,
          status: status,
          statusUpdateDate: statusUpdateDate,
          articles: articles,
          creationDate: creationDate,
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

  static final dummyRetail = ArticleCalibre<ArticleRetail>(
    id: 1,
    articles: [ArticleRetail.dummy],
    title: 'dummy',
    status: true,
    creationDate: WeebiDates.defaultDate,
    updateDate: WeebiDates.defaultDate,
    isPalpable: true,
  );

  static final dummyRetailDecimal = ArticleCalibre<ArticleRetail>(
    id: 3,
    articles: [ArticleRetail.dummyDecimal],
    title: 'dummyDecimal',
    status: true,
    creationDate: WeebiDates.defaultDate,
    isPalpable: true,
  );

  static final dummyBasket = ArticleCalibre<ArticleBasket>(
      id: 2,
      categories: null,
      title: 'truc bis',
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
      'id': id,
      'isPalpable': isPalpable ?? true,
      'title': title,
      'stockUnit': stockUnit.toString(),
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

  static ArticleCalibre<ArticleRetail> fromMapArticleRetail(
      Map<String, dynamic> map) {
    return ArticleCalibre<ArticleRetail>(
      id: map['id'],
      title: map['title'],
      isPalpable: map['isPalpable'] ?? true,
      stockUnit: StockUnit.tryParse(map['stockUnit'] ?? ''),
      creationDate: map['creationDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.parse(map['creationDate']),
      updateDate: map['updateDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.parse(map['updateDate']),
      status: map['status'],
      statusUpdateDate: map['statusUpdateDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.parse(map['statusUpdateDate']),
      articles: map['articles'] == null || map['articles'] == []
          ? <ArticleRetail>[]
          : List<ArticleRetail>.from(
              map['articles'].map((x) => ArticleRetail.fromMap(x))),
      categories: map["categories"] == null
          ? []
          : List<String>.from(map["categories"].map((x) => x)),
    );
  }

  static ArticleCalibre<ArticleBasket> fromMapArticleBasket(
      Map<String, dynamic> map) {
    return ArticleCalibre<ArticleBasket>(
      id: map['id'],
      title: map['title'],
      isPalpable: map['isPalpable'] ?? true,
      stockUnit: StockUnit.tryParse(map['stockUnit'] ?? ''),
      creationDate: map['creationDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.parse(map['creationDate']),
      updateDate: map['updateDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.parse(map['updateDate']),
      status: map['status'],
      statusUpdateDate: map['statusUpdateDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.parse(map['statusUpdateDate']),
      articles: map['articles'] == null || map['articles'] == []
          ? <ArticleBasket>[]
          : List<ArticleBasket>.from(
              map['articles'].map((x) => ArticleBasket.fromMap(x))),
      categories: map["categories"] == null
          ? []
          : List<String>.from(map["categories"].map((x) => x)),
    );
  }

  factory ArticleCalibre.fromJson(String source) =>
      ArticleCalibre.fromMap(json.decode(source));

  factory ArticleCalibre.fromMap(Map<String, dynamic> map) {
    return ArticleCalibre<A>(
      id: map['id'],
      title: map['title'],
      isPalpable: map['isPalpable'] ?? true,
      stockUnit: StockUnit.tryParse(map['stockUnit'] ?? ''),
      creationDate: map['creationDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.parse(map['creationDate']),
      updateDate: map['updateDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.parse(map['updateDate']),
      status: map['status'],
      statusUpdateDate: map['statusUpdateDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.parse(map['statusUpdateDate']),
      articles: map['articles'] == null || map['articles'] == []
          ? []
          : List<A>.from(
              map['articles'].map((x) {
                if (x['discountAmount'] != null || x['proxies'] != null) {
                  return ArticleBasket.fromMap(x);
                } else {
                  return ArticleRetail.fromMap(x);
                }
              }),
            ),
      categories: map["categories"] == null
          ? []
          : List<String>.from(map["categories"].map((x) => x)),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  ArticleCalibre<A> copyWith({
    String? shopUuid,
    int? id,
    String? title,
    bool? isPalpable,
    StockUnit? stockUnit,
    String? photo,
    bool? status,
    DateTime? statusUpdateDate,
    List<A>? articles,
    DateTime? creationDate,
    DateTime? updateDate,
    List<String>? categories,
  }) {
    return ArticleCalibre<A>(
      // shopUuid: shopUuid ?? this.shopUuid,
      id: id ?? this.id,
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
  int get hashCode => id.hashCode ^ isPalpable.hashCode ^ creationDate.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (isBasket) {
      final listEquals = const DeepCollectionEquality().equals;
      return other is ArticleCalibre &&
          other.id == id &&
          other.isPalpable == isPalpable &&
          listEquals(other.articles as List<ArticleRetail>, articles);
    } else {
      return other is ArticleCalibre &&
          other.id == id &&
          other.isPalpable == isPalpable &&
          articles.first == articles.first;
    }
  }

  static final jams = ArticleCalibresDummyJamsBM.jamsData;
  static final jamsPhoto = ArticleCalibresDummyJamsBM.jamsPhotos;
}
