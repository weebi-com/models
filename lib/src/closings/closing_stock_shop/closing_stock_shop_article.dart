import 'package:models_weebi/src/closings/abstract/closing_shop.dart';
import 'package:models_weebi/src/closings/closing_stock_article.dart';
import 'package:models_base/utils.dart';

class ClosingStockShopArticle extends ClosingStockArticle
    implements ClosingShopAbstract {
  @override
  String shopUuid;

  ClosingStockShopArticle(
    DateTime closingDate, {
    this.shopUuid = '',
    required int productId,
    required int id,
    required String fullName,
    required double weight,
    required double quantityIn,
    required double quantityOut,
    required double initialQtCl,
    required double finalQtCl,
  }) : super(
          closingDate,
          productId: productId,
          id: id,
          weight: weight,
          fullName: fullName,
          initialQtCl: initialQtCl,
          finalQtCl: initialQtCl,
          quantityIn: quantityIn,
          quantityOut: quantityOut,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      'closingDate': closingDate.toIso8601String(),
      'shopUuid': shopUuid,
      'productId': productId,
      'id': id,
      'fullName': fullName,
      'weight': weight,
      'quantityIn': quantityIn,
      'quantityOut': quantityOut,
      'initialQtCl': initialQtCl,
      'finalQtCl': finalQtCl,
    };
  }

  factory ClosingStockShopArticle.fromMap(Map<String, dynamic> map) {
    return ClosingStockShopArticle(
      DateTime.tryParse(map['closingDate']) ?? WeebiDates.defaultDate,
      shopUuid: map['shopUuid'] as String,
      productId: map['productId'] as int,
      id: map['id'] as int,
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
}
