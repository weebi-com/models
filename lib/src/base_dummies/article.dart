import 'package:models_weebi/src/base/article_base.dart';
import 'package:models_weebi/src/utils/dates.dart';

class ArticleDummy extends ArticleAbstract {
  ArticleDummy()
      : super(
          calibreId: 1,
          id: 1,
          fullName: 'frometon forever',
          weight: 1,
          articleCode: 11,
          creationDate: WeebiDates.defaultDate,
          status: true,
        );
}
