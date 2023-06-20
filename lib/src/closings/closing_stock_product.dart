import 'package:models_weebi/src/closings/abstract/closing_range.dart';
import 'package:models_weebi/src/closings/abstract/stock_quantity.dart';
import 'package:models_weebi/src/closings/closing_range.dart';
import 'package:models_weebi/src/closings/closing_stock_article.dart';

import 'package:models_base/base.dart';
import 'package:models_weebi/utils.dart';

class ClosingStockProduct extends ArticleCalibreAbstract<ClosingStockArticle>
    implements ClosingDateAbstract, StockQuantityAbstract {
  @override
  DateTime closingDate;
  @override
  double initialQtCl;
  @override
  double finalQtCl;
  ClosingStockProduct(
    this.closingDate, {
    required int id,
    required String title,
    required this.initialQtCl,
    required this.finalQtCl,
    required List<ClosingStockArticle> articles,
    bool status = true,
  }) : super(
          id: id,
          title: title,
          articles: articles,
          status: true,
          creationDate: DateTime.now(),
        );

  static final cStockProductDummy = ClosingStockProduct(
    ClosingRange.dummyFeb.date,
    id: 1,
    title: 'fromage abondance',
    initialQtCl: 0.0,
    finalQtCl: 5.0,
    articles: [
      ClosingStockArticle(ClosingRange.dummyFeb.date,
          quantityIn: 5.0,
          quantityOut: 0.0,
          id: 1,
          productId: 1,
          fullName: 'fromage abondance kg',
          weight: 1.0,
          finalQtCl: 5.0,
          initialQtCl: 0.0),
    ],
  );

  @override
  Map<String, dynamic> toMap() {
    return {
      'closingDate': closingDate.toIso8601String(),
      'id': id,
      'title': title,
      'initialQtCl': initialQtCl,
      'finalQtCl': finalQtCl,
      'articles': articles.map((e) => e.toMap()).toList(),
    };
  }

  factory ClosingStockProduct.fromMap(Map<String, dynamic> map) =>
      ClosingStockProduct(
        DateTime.tryParse(map['closingDate']) ?? WeebiDates.defaultDate,
        id: map['id'] as int,
        title: map['title'] as String,
        articles: map['articles'] == null
            ? []
            : List<ClosingStockArticle>.from(
                map['articles']?.map((x) => ClosingStockArticle.fromMap(x))),
        initialQtCl: map['initialQtCl'] == null
            ? 0.0
            : (map['initialQtCl'] as num).toDouble(),
        finalQtCl: map['finalQtCl'] == null
            ? 0.0
            : (map['finalQtCl'] as num).toDouble(),
      );

  @override
  bool operator ==(Object other) => identical(closingDate, other);
  @override
  int get hashCode => closingDate.hashCode;
}
