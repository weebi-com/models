import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:models_base/base.dart'
    show ArticleAbstract, LineArticleAbstract;
import 'package:models_base/common.dart';
import 'package:models_base/utils.dart';
import 'package:models_weebi/src/models/article_basket.dart';
import 'package:models_weebi/src/models/article.dart';
import 'package:collection/collection.dart';

class LineOfArticles<A extends ArticleAbstract> extends LineArticleAbstract<A> {
  // final String? shopUuid;
  // String? get shopId => shopUuid;
  final bool? isPalpable;
  final bool? isBasket;
  bool get isSingleArticle => articles.length <= 1;
  @override
  String get photo => articles.isEmpty ? '' : articles.first.photo ?? '';
  LineOfArticles({
    required int id,
    // required this.shopUuid,
    this.isPalpable = true,
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

  static final dummy = LineOfArticles<Article>(
      // shopUuid: 'shopUuid',
      id: 1,
      articles: [Article.dummy],
      title: 'dummy',
      status: true,
      creationDate: WeebiDates.defaultDate,
      updateDate: WeebiDates.defaultDate,
      isPalpable: true,
      isBasket: false);

  static final dummyBasket = LineOfArticles<ArticleBasket>(
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
      'photo': photo ?? '',
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

  LineOfArticles<Article> fromMapArticleWeebi(Map<String, dynamic> map) {
    if ((map['isBasket'] ?? false) == false) {
      return LineOfArticles.fromMap(map);
    } else {
      throw 'this is a basket';
    }
  }

  LineOfArticles<ArticleBasket> fromMapArticleBasket(Map<String, dynamic> map) {
    if ((map['isBasket'] ?? false) == false) {
      throw 'this is not a basket';
    } else {
      return LineOfArticles.fromMap(map);
    }
  }

  factory LineOfArticles.fromMap(Map<String, dynamic> map) {
    return LineOfArticles<A>(
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
                return Article.fromMap(x);
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

  factory LineOfArticles.fromJson(String source) =>
      LineOfArticles.fromMap(json.decode(source));

  LineOfArticles<A> copyWith({
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
    return LineOfArticles(
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
    return other is LineOfArticles &&
        // other.shopUuid == shopUuid &&
        other.id == id &&
        other.isPalpable == isPalpable &&
        listEquals(other.articles, articles);
  }
}
