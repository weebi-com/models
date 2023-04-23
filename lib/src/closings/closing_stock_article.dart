import 'dart:convert';
import 'package:models_base/base.dart';

import 'package:models_base/utils.dart';
import 'package:models_weebi/src/closings/abstract/closing_range.dart';
import 'package:models_weebi/src/closings/abstract/stock_quantity.dart';

class ClosingStockArticle extends ArticleAbstract
    implements ClosingDateAbstract, StockQuantityAbstract {
  @override
  DateTime closingDate;
  @override
  double initialQtCl;
  @override
  double finalQtCl;

  double quantityIn;
  double quantityOut;
  final int articleId;
  ClosingStockArticle(
    this.closingDate, {
    required int productId,
    required int id,
    required String fullName,
    required double weight,
    // int price,
    // int cost,
    required this.initialQtCl,
    required this.finalQtCl,
    required this.quantityIn,
    required this.quantityOut,
  })  : articleId = id,
        super(
          lineId: productId,
          id: id,
          weight: weight,
          fullName: fullName,
          status: true,
          creationDate: DateTime.now(),
          updateDate: DateTime.now(),
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'closingDate': closingDate.toIso8601String(),
      'initialQtCl': initialQtCl,
      'finalQtCl': finalQtCl,
      'quantityIn': quantityIn,
      'quantityOut': quantityOut,
      'fullName': fullName,
      'weight': weight,
      // 'price': price,
      // 'cost': cost,
    };
  }

  factory ClosingStockArticle.fromMap(Map<String, dynamic> map) {
    return ClosingStockArticle(
      DateTime?.tryParse(map['closingDate']) ?? WeebiDates.defaultDate,
      id: map['id'] ?? map['articleId'] as int,
      productId: map['productId'] as int,
      // price: map['price'] ?? 0,
      // cost: map['cost'] ?? 0,
      fullName: map['fullName'] as String,
      weight: map['weight'] == null ? 1.0 : (map['weight'] as num).toDouble(),
      quantityIn: map['quantityIn'] == null
          ? 0.0
          : (map['quantityIn'] as num).toDouble(),
      quantityOut: map['quantityOut'] == null
          ? 0.0
          : (map['quantityOut'] as num).toDouble(),
      initialQtCl: map['initialQtCl'] == null
          ? 0.0
          : (map['initialQtCl'] as num).toDouble(),
      finalQtCl:
          map['finalQtCl'] == null ? 0.0 : (map['finalQtCl'] as num).toDouble(),
    );
  }
  @override
  String toJson() => json.encode(toMap());
}
