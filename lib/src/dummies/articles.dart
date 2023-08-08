import 'package:models_weebi/common.dart';
import 'package:models_weebi/utils.dart';
import 'package:models_weebi/weebi_models.dart';

class DummyArticleData {
  static final allDummies = [...cola, ...babibel, sugar];
  static final sugar = ArticleCalibre(
    id: 3,
    title: 'Sucre',
    stockUnit: StockUnit.gram,
    status: true,
    statusUpdateDate: WeebiDates.defaultDate,
    creationDate: WeebiDates.defaultDate,
    updateDate: WeebiDates.defaultDate,
    articles: [
      ArticleRetail(
        calibreId: 3,
        id: 1,
        fullName: 'Sucre g',
        weight: 1.0,
        price: 10,
        cost: 5,
        articleCode: 31,
        creationDate: WeebiDates.defaultDate,
        updateDate: WeebiDates.defaultDate,
      )
    ],
  );

  static final babibel = [
    ArticleCalibre(
      id: 2,
      title: 'Babibel',
      stockUnit: StockUnit.unit,
      status: true,
      creationDate: WeebiDates.defaultDate,
      articles: [
        ArticleRetail(
          calibreId: 2,
          id: 1,
          fullName: 'Babibel x1',
          weight: 1.0,
          price: 100,
          cost: 50,
          articleCode: 11,
          creationDate: WeebiDates.defaultDate,
        ),
        ArticleRetail(
          calibreId: 2,
          id: 2,
          fullName: 'Babibel x12',
          weight: 12.0,
          price: 1000,
          cost: 500,
          articleCode: 12,
          creationDate: WeebiDates.defaultDate,
        ),
        ArticleRetail(
          calibreId: 2,
          id: 3,
          fullName: 'Babibel sac x28',
          weight: 28.0,
          price: 9000,
          cost: 4500,
          articleCode: 13,
          creationDate: WeebiDates.defaultDate,
        ),
      ],
    ),
  ];

  static final cola = [
    ArticleCalibre(
      id: 1,
      title: 'Noix de cola',
      categories: [''],
      stockUnit: StockUnit.unit,
      status: true,
      creationDate: WeebiDates.defaultDate,
      articles: [
        ArticleRetail(
          calibreId: 1,
          id: 1,
          fullName: 'Noix de cola x1',
          weight: 1.0,
          price: 100,
          cost: 50,
          articleCode: 11,
          creationDate: WeebiDates.defaultDate,
        ),
        ArticleRetail(
          calibreId: 1,
          id: 2,
          fullName: 'Noix de cola x6',
          weight: 6.0,
          price: 500,
          cost: 250,
          articleCode: 12,
          creationDate: WeebiDates.defaultDate,
        ),
        ArticleRetail(
          calibreId: 1,
          id: 3,
          fullName: 'Noix de cola sac x100',
          weight: 100.0,
          price: 9000,
          cost: 4500,
          articleCode: 13,
          // photo: cola100Base64,
          // photoSource: PhotoSource.memory,
          creationDate: WeebiDates.defaultDate,
        ),
      ],
    ),
  ];
}

const cola100Base64 = '/9'; // will fail to check that error image is displayed
