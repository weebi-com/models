import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:models_common/utils.dart';

import 'package:models_weebi/src/weebi/article_weebi.dart';
import 'package:models_base/base.dart' show ProductAbstract;
import 'package:models_common/common.dart';

class ProductWeebi extends ProductAbstract<ArticleWeebi> {
  final String? shopUuid;

  ProductWeebi({
    this.shopUuid,
    required List<ArticleWeebi> articles,
    required int id,
    List<String>? categories,
    required String title,
    StockUnit stockUnit = StockUnit.unit,
    int? barcode,
    String? photo,
    @observable required bool status,
    DateTime? statusUpdateDate,
    required DateTime creationDate,
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
        );

// use a mixin ?
  String get sharableText {
    final truc = StringBuffer();
    for (var article in articles) {
      final qt = article.lots?.fold(0.0,
          (double lotValue, lot) => lotValue + lot.quantity * article.weight);
      truc.write(numFormat.format(qt));
    }
    final sb = StringBuffer()
      ..writeln('# $id - $title')
      ..writeln('stock : ${truc.toString()}');
    return sb.toString();
  }

  static final dummy = ProductWeebi(
    articles: [ArticleWeebi.dummy],
    id: 1,
    title: 'dummy',
    status: true,
    creationDate: WeebiDates.defaultDate,
  );
  @override
  Map<String, dynamic> toMap() {
    return {
      'shopUuid': shopUuid,
      'id': id,
      'title': title,
      'stockUnit': stockUnit.toString(),
      'photo': photo ?? '',
      'barcode': barcode ?? 0,
      'status': status,
      'statusUpdateDate': statusUpdateDate!.toIso8601String(),
      'articles': articles.map((x) => x.toMap()).toList(),
      'creationDate': creationDate!.toIso8601String(),
      'categories': categories!.map((e) => e).toList(),
    };
  }

  factory ProductWeebi.fromMap(Map<String, dynamic> map) {
    return ProductWeebi(
      shopUuid: map['shopUuid'] ?? '',
      id: map['id'],
      title: map['title'],
      stockUnit: StockUnit.tryParse(map['stockUnit'] ?? ''),
      photo: map['photo'] ?? '',
      barcode: map['barcode'] ?? 0,
      creationDate: map['creationDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.parse(map['creationDate']),
      status: map['status'],
      statusUpdateDate: map['statusUpdateDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.parse(map['statusUpdateDate']),
      articles: List<ArticleWeebi>.from(
          map['articles']?.map((x) => ArticleWeebi.fromMap(x))),
      categories: map["categories"] == null
          ? []
          : List<String>.from(map["categories"].map((x) => x)),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory ProductWeebi.fromJson(String source) =>
      ProductWeebi.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductWeebi && other.shopUuid == shopUuid;
  }

  @override
  int get hashCode => shopUuid.hashCode;
}
