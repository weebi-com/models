import 'package:models_weebi/src/closings/abstract/closing_shop.dart';
import 'package:models_weebi/src/closings/closing_stock.dart';
import 'package:meta/meta.dart';

import 'package:models_weebi/src/closings/closing_range.dart';
import 'package:models_weebi/src/closings/closing_stock_shop/closing_stock_shop_article.dart';
import 'package:models_weebi/src/closings/closing_stock_shop/closing_stock_shop_product.dart';

class ClosingStockShop<P extends ClosingStockShopProduct>
    extends ClosingStock<P> implements ClosingShopAbstract {
  @override
  String shopUuid;
  ClosingStockShop(
    ClosingRange closingRange, {
    required this.shopUuid,
    List<P>? products,
  }) : super(closingRange, products: products ?? []);

  @override
  bool operator ==(other) => identical(closingRange, other);
  @override
  int get hashCode => closingRange.hashCode;

  @override
  Map<String, dynamic> toMap() {
    return {
      'shopUuid': shopUuid,
      'closingRange': closingRange.toMap(),
      'products': products?.map((x) => x.toMap())?.toList(),
    };
  }

  factory ClosingStockShop.fromMap(Map<String, dynamic> map) {
    return ClosingStockShop(
      ClosingRange.fromMap(map['closingRange']),
      shopUuid: map['shopUuid'],
      products: map['products'] == null
          ? []
          : List<P>.from(
              map['products']?.map((x) => ClosingStockShopProduct.fromMap(x))),
    );
  }
  static final dummyFeb = [
    ClosingStockShop(
      ClosingRange.dummyFeb,
      shopUuid: 'pierre_entrepot',
      products: [
        ClosingStockShopProduct(ClosingRange.dummyFeb.date,
            id: 1,
            shopUuid: 'pierre_entrepot',
            title: 'abondance',
            initialQtCl: 0.0,
            finalQtCl: 3.0,
            articles: [
              ClosingStockShopArticle(
                ClosingRange.dummyFeb.date,
                productId: 1,
                id: 1,
                shopUuid: 'pierre_entrepot',
                fullName: 'fromage abondance kg',
                weight: 1.0,
                quantityIn: 3.0,
                quantityOut: 0.0,
                initialQtCl: 0.0,
                finalQtCl: 3.0,
              ),
            ]),
      ],
    ),
  ];
  static final dummyMar = [
    ClosingStockShop(
      ClosingRange.dummyMar,
      shopUuid: 'pierre_entrepot',
      products: [
        ClosingStockShopProduct(ClosingRange.dummyMar.date,
            id: 1,
            shopUuid: 'pierre_entrepot',
            title: 'abondance',
            initialQtCl: 3.0,
            finalQtCl: 5.0,
            articles: [
              ClosingStockShopArticle(
                ClosingRange.dummyMar.date,
                productId: 1,
                id: 1,
                shopUuid: 'pierre_entrepot',
                fullName: 'fromage abondance kg',
                weight: 1.0,
                quantityIn: 2.0,
                quantityOut: 0.0,
                initialQtCl: 3.0,
                finalQtCl: 5.0,
              ),
            ]),
      ],
    ),
  ];
}
