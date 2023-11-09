import 'package:models_weebi/common.dart';
import 'package:models_weebi/src/base/article_calibre_base.dart';
import 'package:models_weebi/src/base_dummies/article.dart';
import 'package:models_weebi/utils.dart';

class ArticleCalibreDummy extends ArticleCalibreAbstract {
  ArticleCalibreDummy()
      : super(
          id: 1,
          title: 'frometon',
          status: true,
          articles: [ArticleDummy()],
          stockUnit: StockUnit.unit,
          categories: ['categories'],
          barcode: 1,
          creationDate: WeebiDates.defaultDate,
          statusUpdateDate: WeebiDates.defaultDate,
        );
}
