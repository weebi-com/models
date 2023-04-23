library report_stock_product;

import 'package:models_base/base.dart' show ArticleLineAbstract;
import 'package:models_base/utils.dart' show DateRange;
import 'package:models_weebi/src/closings/abstract/stock_quantity.dart';
import 'package:models_weebi/src/closings/report_stock_article.dart';

class ReportStockProduct extends ArticleLineAbstract<ReportStockArticle>
    implements DateRange, StockQuantityAbstract {
  @override
  double initialQtCl = 0.0; // closing initial qt
  @override
  double finalQtCl = 0.0; // closing final qt
  double varQtTickets = 0.0; // we do not have initialQtTickets only final
  // double initialQtTickets = 0.0;
  // double get finalQtSuper => (finalQtCl ?? 0.0) + (finalQtTickets ?? 0.0);
  double get qtVariationDuringATimeRangeSuper =>
      (varQtTickets) +
      (finalQtCl - initialQtCl); // variation archives + tickets
  // * toRuminate weight reconciliation incompatible yet

  @override
  DateTime startDate;
  @override
  DateTime endDate;

  ReportStockProduct({
    required int id,
    required String title,
    required this.startDate,
    required this.endDate,
    required this.initialQtCl,
    required this.finalQtCl,
    required this.varQtTickets,
    List<ReportStockArticle>? articles,
    // ignore: missing_required_param
  }) : super(
          id: id,
          title: title,
          articles: articles ?? [],
          status: true,
          creationDate: DateTime.now(),
          updateDate: DateTime.now(),
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'initialQtCl': initialQtCl,
      'finalQtCl': finalQtCl,
      'finalQtTickets': varQtTickets,
      // articles to be added
    };
  }
}
