import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import 'package:models_weebi/common.dart' show StockUnit;
import 'package:models_weebi/src/base/article_base.dart';

abstract class ArticleCalibreAbstract<T extends ArticleAbstract> {
  final int id;
  final String title;
  final StockUnit stockUnit;
  final int? barcode; // * barcode -> generic code not sku
  final DateTime? statusUpdateDate;
  final List<T> articles;
  final List<String>? categories; // line != categories
  final DateTime? creationDate;
  final DateTime? updateDate;

  @observable
  final bool status;
  bool get hasSingleArticle => articles.length <= 1;

  const ArticleCalibreAbstract({
    required this.id,
    required this.title,
    required this.articles,
    this.stockUnit = StockUnit.unit,
    this.categories,
    this.barcode,
    this.statusUpdateDate,
    required this.creationDate,
    required this.status,
  }) : updateDate = creationDate;

  // factory Product.fromJson(Map<String, dynamic> json) =>
  //     _$ProductFromJson(json);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'stockUnit': stockUnit.toString(),
      'barcode': barcode ?? 0,
      'status': status,
      'statusUpdateDate': statusUpdateDate?.toIso8601String(),
      'articles': articles.map((x) => x.toMap()).toList(),
      'creationDate':
          creationDate == null ? '' : creationDate?.toIso8601String(),
      'updateDate': updateDate == null ? '' : updateDate?.toIso8601String(),
      'categories': categories?.map((e) => e).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return '''
ArticleCalibre(
  id: $id,
  title: $title,
  stockUnit: $stockUnit,
  barcode: $barcode,
  statusUpdateDate: $statusUpdateDate,
  updateDate: $updateDate,
  creationDate: $creationDate,
  status: $status,
  articles: $articles)  
    ''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is ArticleCalibreAbstract<T> &&
        other.id == id &&
        other.title == title &&
        other.stockUnit == stockUnit &&
        other.barcode == barcode &&
        other.status == status &&
        other.statusUpdateDate == statusUpdateDate &&
        listEquals(other.articles, articles) &&
        other.creationDate == creationDate &&
        other.updateDate == updateDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        stockUnit.hashCode ^
        barcode.hashCode ^
        status.hashCode ^
        statusUpdateDate.hashCode ^
        articles.hashCode ^
        creationDate.hashCode ^
        updateDate.hashCode;
  }
}
