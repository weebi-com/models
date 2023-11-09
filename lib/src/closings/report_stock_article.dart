import 'package:models_weebi/base.dart' show ArticleAbstract;
import 'package:models_weebi/utils.dart' show DateRange;
import 'package:models_weebi/src/closings/abstract/stock_quantity.dart';

class ReportStockArticle extends ArticleAbstract
    implements DateRange, StockQuantityAbstract {
  @override
  double initialQtCl;
  @override
  double finalQtCl;
  @override
  DateTime startDate;
  @override
  DateTime endDate;
  double qtIn;
  double qtOut;
  ReportStockArticle({
    required int productId,
    required int id,
    required this.startDate,
    required this.endDate,
    required this.initialQtCl,
    required this.finalQtCl,
    required this.qtIn,
    required this.qtOut,
    required String fullName,
  }) : super(
          calibreId: productId,
          id: id,
          fullName: fullName,
          creationDate: DateTime.now(),
          status: true,
        );
}
