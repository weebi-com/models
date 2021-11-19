import 'dart:convert';

import 'package:mobx/mobx.dart';

import 'package:weebi_models/src/weebi/article_weebi.dart';
import 'package:models/base.dart';
import 'package:models/common.dart';

class ProductWeebi extends Product<ArticleWeebi> {
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

  // TODO pursue with http
  // static Future<WeebiStatus> postProductsWeebi(List<Product> products) async {
  //   final url = webhookUrl + 'products_post';
  //   final resultString = products.map((p) => p.toRawJson()).toList();
  //   final response =
  //       await http.post(Uri.parse(url), body: resultString.toString());
  //   // print(url);
  //   // print(response.body);
  //   return getHttpStatus(response.body);
  // }

  // static Future<List<Product>> downloadProductsWeebi(
  //     bool isProd, String shopUuid) async {
  //   var url = webhookUrl + 'products_get' + '?shopUuid=$shopUuid';

  //   var response = await http.get(Uri.parse(url));
  //   final cleanBody = response.body.substring(
  //       1, response.body.length - 1); // clean quotes that mongo returns
  //   final cleanBodyParsed = json.decode(cleanBody.replaceAll(r'\', '')) as List;

  //   return List<Product>.from(cleanBodyParsed
  //       .cast<Map>()
  //       .cast<Map<String, dynamic>>()
  //       .map((product) => Product.fromMap(product)));
  // }
  @override
  Map<String, dynamic> toMap() {
    return {
      'shopUuid': shopUuid,
      'id': id,
      'title': title,
      'stockUnit': stockUnit.toMap(),
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
      stockUnit: StockUnit.fromMap(map['stockUnit']),
      photo: map['photo'] ?? '',
      barcode: map['barcode'] ?? 0,
      status: map['status'],
      statusUpdateDate: DateTime.tryParse(map['statusUpdateDate']),
      articles: List<ArticleWeebi>.from(
          map['articles']?.map((x) => ArticleWeebi.fromMap(x))),
      creationDate: DateTime.tryParse(map['creationDate']) ?? defaultDate,
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
