import 'package:models_weebi/common.dart';
import 'package:models_weebi/utils.dart';
import 'package:models_weebi/weebi_models.dart';

class DummyArticleData {
  static final cola = [
    LineOfArticles(
      id: 1,
      title: 'Noix de cola',
      categories: [''],
      stockUnit: StockUnit.unit,
      photo: '',
      status: true,
      statusUpdateDate: WeebiDates.defaultDate,
      creationDate: WeebiDates.defaultDate,
      updateDate: WeebiDates.defaultDate,
      articles: [
        Article(
          lineId: 1,
          id: 1,
          fullName: 'Noix de cola x1',
          weight: 1.0,
          price: 100,
          cost: 50,
          articleCode: 11,
          photo: '',
          creationDate: WeebiDates.defaultDate,
          updateDate: WeebiDates.defaultDate,
        ),
        Article(
          lineId: 1,
          id: 2,
          fullName: 'Noix de cola x6',
          weight: 6.0,
          price: 1000,
          cost: 500,
          articleCode: 12,
          photo: '',
          creationDate: WeebiDates.defaultDate,
          updateDate: WeebiDates.defaultDate,
        ),
        Article(
          lineId: 1,
          id: 3,
          fullName: 'Noix de cola sac x100',
          weight: 100.0,
          price: 9000,
          cost: 4500,
          articleCode: 13,
          photo: '',
          creationDate: WeebiDates.defaultDate,
          updateDate: WeebiDates.defaultDate,
        ),
      ],
    ),
  ];
}
