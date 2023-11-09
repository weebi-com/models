import 'dart:convert';
import 'package:models_weebi/src/closings/abstract/closing_herder.dart';
import 'package:models_weebi/src/closings/closing_range.dart';
import 'package:models_weebi/src/closings/closing_stock.dart';
import 'package:models_weebi/src/closings/closing_stock_product.dart';
import 'package:models_weebi/src/closings/closing_stock_article.dart';
import 'package:models_weebi/base.dart' show ArticleCalibreAbstract;

import 'package:models_weebi/utils.dart' show DateRange;
import 'package:models_weebi/src/closings/report_stock_product.dart';

extension FinFlowClosingHerderStock on List<ClosingStockHerder> {
  List<ReportStockProduct> herderReportStockProduct(
    String herderId,
    List<ArticleCalibreAbstract> products,
    DateRange dateRange,
    List<ReportStockProduct> emptyReportStockProducts,
  ) {
    forEach((c) {
      if (c.herderId == herderId &&
          (c.closingRange.startDate.isAfter(dateRange.startDate) ||
              c.closingRange.startDate.isAtSameMomentAs(dateRange.startDate)) &&
          (c.closingRange.endDate.isBefore(dateRange.endDate) ||
              c.closingRange.endDate.isAtSameMomentAs(dateRange.endDate))) {
        for (var p in products) {
          if (c.products.any((i) => i.id == p.id)) {
            // NOT any products can be both bought & sold
            // so we SUM ALL movements
            emptyReportStockProducts
                    .firstWhere((reportStockP) => reportStockP.id == p.id)
                    .finalQtCl +=
                c.products
                    .firstWhere((clsoingStockP) => clsoingStockP.id == p.id)
                    .finalQtCl;
          } else {
            print('closings do not fit requirements');
          }
        }
      }
    });
    return emptyReportStockProducts;
  }
}

class ClosingStockHerder extends ClosingStock implements ClosingHerderAbstract {
  @override
  String herderId;
  ClosingStockHerder(ClosingRange closingRange,
      {required this.herderId, List<ClosingStockProduct>? products})
      : super(closingRange, products: products ?? []);

  @override
  Map<String, dynamic> toMap() {
    return {
      'closingRange': closingRange.toMap(), // ?
      'herderId': herderId,
      'products': products.map((e) => e.toMap()).toList(),
    };
  }

  factory ClosingStockHerder.fromJson(String source) =>
      ClosingStockHerder.fromMap(json.decode(source));

  factory ClosingStockHerder.fromMap(Map<String, dynamic> map) {
    return ClosingStockHerder(
      // ignore: missing_required_param
      ClosingRange.fromMap(map['closingRange']),
      products: map['products'] == null
          ? []
          : List<ClosingStockProduct>.from(
              map['products']?.map((x) => ClosingStockProduct.fromMap(x)) ??
                  const []),
      herderId: map['herderId'] ?? '',
    );
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClosingStockHerder && other.herderId == herderId;
  }

  @override
  int get hashCode => herderId.hashCode;

  static final milkDummy = [
    ClosingStockHerder(ClosingRange.dummyLastMonth, herderId: '1', products: [
      ClosingStockProduct(
        ClosingRange.dummyLastMonth.date,
        id: 6,
        title: 'milk',
        initialQtCl: 0.0,
        finalQtCl: 20.0,
        articles: [
          ClosingStockArticle(ClosingRange.dummyLastMonth.date,
              quantityIn: 20.0,
              quantityOut: 0.0,
              id: 1,
              productId: 6,
              fullName: 'milk',
              weight: 1.0,
              finalQtCl: 20.0,
              initialQtCl: 0.0),
        ],
      ),
    ])
  ];
}
