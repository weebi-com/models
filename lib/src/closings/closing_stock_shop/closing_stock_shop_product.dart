import 'package:models_weebi/src/closings/abstract/closing_shop.dart';
import 'package:models_weebi/src/closings/closing_stock_product.dart';
import 'package:models_weebi/src/closings/closing_range.dart';
import 'package:models_weebi/src/closings/closing_stock_shop/closing_stock_shop_article.dart';
import 'package:models_base/utils.dart';

class ClosingStockShopProduct extends ClosingStockProduct
    implements ClosingShopAbstract {
//  le shopUuid pour être en mesure de retrouver l'historique d'un produit, notammnent si l'on doit analyser des transferts entre magasin
  @override
  String shopUuid;

  ClosingStockShopProduct(
    DateTime closingDate, {
    required this.shopUuid,
    required int id,
    required String title,
    required double initialQtCl,
    required double finalQtCl,
    required List<ClosingStockShopArticle> articles,
    bool status = true,
  }) : super(closingDate,
            id: id,
            title: title,
            initialQtCl: initialQtCl,
            finalQtCl: finalQtCl,
            articles: articles,
            status: status);

  factory ClosingStockShopProduct.fromMap(Map<String, dynamic> map) {
    return ClosingStockShopProduct(
      DateTime.tryParse(map['closingDate']) ?? WeebiDates.defaultDate,
      shopUuid: map['shopUuid'],
      id: map['id'],
      title: map['title'],
      status: map['status'],
      initialQtCl: map['initialQtCl'] == null
          ? 0.0
          : (map['initialQtCl'] as num).toDouble(),
      finalQtCl:
          map['finalQtCl'] == null ? 0.0 : (map['finalQtCl'] as num).toDouble(),
      articles: map['articles'] == null
          ? []
          : List<ClosingStockShopArticle>.from(
              map['articles']?.map((x) => ClosingStockShopArticle.fromMap(x))),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'closingDate': closingDate.toIso8601String(),
      'shopUuid': shopUuid,
      'id': id,
      'title': title,
      'initialQtCl': initialQtCl,
      'finalQtCl': finalQtCl,
      'articles': articles.map((x) => x.toMap()).toList(),
    };
  }

  static final closingStockShopProductsDummy = ClosingStockShopProduct(
      ClosingRange.dummyFeb.date,
      shopUuid: 'pierre_entrepot',
      initialQtCl: 0,
      finalQtCl: 10,
      title: 'test',
      id: 1,
      articles: [
        ClosingStockShopArticle(
          ClosingRange.dummyFeb.date,
          productId: 1,
          id: 1,
          fullName: 'test',
          weight: 1,
          quantityIn: 10.0,
          quantityOut: 0.0,
          initialQtCl: 0.0,
          finalQtCl: 10.0,
        )
      ]);
}
