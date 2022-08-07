import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:models_base/base.dart' show LineArticleAbstract;
import 'package:models_base/common.dart';
import 'package:models_base/utils.dart';
import 'package:models_weebi/src/weebi/article_basket.dart';
import 'package:models_weebi/src/weebi/article_weebi.dart';
import 'package:collection/collection.dart';

// TODO test this before going any further
extension BaseModel on Type {
  fromMap(Map<String, dynamic> data) {}
}

class LineArticleWeebi<A extends ArticleWeebi> extends LineArticleAbstract<A> {
  final String? shopUuid;
  String? get shopId => shopUuid;
  final bool? isPalpable;

  LineArticleWeebi({
    required int id,
    this.shopUuid,
    this.isPalpable = true,
    required List<A> articles,
    List<String>? categories,
    required String title,
    StockUnit stockUnit = StockUnit.unit,
    int? barcode,
    String? photo,
    @observable required bool status,
    DateTime? statusUpdateDate,
    required DateTime? creationDate,
    required DateTime? updateDate,
  }) : super(
          id: id,
          categories: categories,
          title: title,
          stockUnit: stockUnit,
          barcode: barcode,
          photo: photo,
          status: status,
          statusUpdateDate: statusUpdateDate,
          articles: articles,
          creationDate: creationDate,
          updateDate: updateDate,
        );

// use a mixin ?
  String get sharableText {
    final truc =
        StringBuffer(); //TODO fix this inherited from old  old stock management
    // for (var a in articles) {
    //   final qt =
    //       a.lots?.fold(0.0, (double lotValue, lot) => lotValue * a.weight);
    //   truc.write(numFormat.format(qt));
    // }
    final sb = StringBuffer()
      ..writeln('# $id - $title')
      ..writeln('stock : ${truc.toString()}');
    return sb.toString();
  }

  static final dummy = LineArticleWeebi(
    articles: [ArticleWeebi.dummy],
    id: 1,
    title: 'dummy',
    status: true,
    creationDate: WeebiDates.defaultDate,
    updateDate: WeebiDates.defaultDate,
  );
  @override
  Map<String, dynamic> toMap() {
    return {
      'shopUuid': shopUuid,
      'id': id,
      'isPalpable': isPalpable ?? true,
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

  factory LineArticleWeebi.fromMap(Map<String, dynamic> map) {
    return LineArticleWeebi(
      shopUuid: map['shopUuid'] ?? '',
      id: map['id'],
      title: map['title'],
      isPalpable: map['isPalpable'] ?? true,
      stockUnit: StockUnit.tryParse(map['stockUnit'] ?? ''),
      photo: map['photo'] ?? '',
      barcode: map['barcode'] ?? 0,
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
      articles: map['articles'] == null
          ? []
          : List<A>.from(map['articles'].map((x) {
              if (x['lots'] == null) {
                return ArticleWeebi.fromMap(x);
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

  factory LineArticleWeebi.fromJson(String source) =>
      LineArticleWeebi.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
    return other is LineArticleWeebi &&
        other.shopUuid == shopUuid &&
        other.isPalpable == isPalpable &&
        listEquals(other.articles, articles);
  }

  copyWith({
    String? shopUuid,
    int? id,
    String? title,
    bool? isPalpable,
    StockUnit? stockUnit,
    String? photo,
    int? barcode,
    bool? status,
    DateTime? statusUpdateDate,
    List<ArticleWeebi>? articles,
    DateTime? creationDate,
    DateTime? updateDate,
    List<String>? categories,
  }) {
    return LineArticleWeebi(
      shopUuid: shopUuid ?? this.shopUuid,
      id: id ?? this.id,
      isPalpable: isPalpable ?? this.isPalpable,
      title: title ?? this.title,
      stockUnit: stockUnit ?? this.stockUnit,
      photo: photo ?? this.photo,
      barcode: barcode ?? this.barcode,
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
  int get hashCode => shopUuid.hashCode ^ isPalpable.hashCode;
}
