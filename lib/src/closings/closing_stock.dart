import 'dart:convert';
import 'package:models_weebi/src/closings/abstract/closing_range.dart';
import 'package:models_weebi/src/closings/closing_stock_article.dart';
import 'package:models_weebi/src/closings/closing_range.dart';
import 'package:models_weebi/src/closings/closing_stock_product.dart';

class ClosingStock<C extends ClosingStockProduct>
    implements ClosingRangeAbstract {
  @override
  final ClosingRange closingRange;
  final List<C> products;

  const ClosingStock(
    this.closingRange, {
    required this.products,
  });

  static final dummy = ClosingStock(ClosingRange.dummyFeb, products: [
    ClosingStockProduct(
      ClosingRange.dummyFeb.date,
      id: 1,
      title: 'fromage abondance kg',
      initialQtCl: 0.0,
      finalQtCl: 5.0,
      articles: [
        ClosingStockArticle(ClosingRange.dummyFeb.date,
            quantityIn: 0.0,
            quantityOut: 0.0,
            id: 1,
            productId: 1,
            fullName: 'fromage abondance kg',
            weight: 1.0,
            finalQtCl: 5.0,
            initialQtCl: 0.0),
      ],
    ),
  ]);

  @override
  bool operator ==(Object other) => identical(closingRange, other);
  @override
  int get hashCode => closingRange.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'closingRange': closingRange.toMap(),
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory ClosingStock.fromMap(Map<String, dynamic> map) {
    return ClosingStock(
      ClosingRange.fromMap(map['closingRange']),
      products: map['products'] == null
          ? []
          : List<C>.from(
              map['products'].map((x) => ClosingStockProduct.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ClosingStock.fromJson(String source) =>
      ClosingStock.fromMap(json.decode(source));
}
