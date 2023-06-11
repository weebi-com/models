import 'package:models_weebi/common.dart';
import 'package:models_weebi/src/dummies/base64_cola.dart';
import 'package:models_weebi/utils.dart';
import 'package:models_weebi/weebi_models.dart';

class DummyArticleData {
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
          // photo:'https://drive.google.com/uc?export=view&id=1OidtnGPK9iA7cZXX-yDX9YmUyrpb63GK',
          photoSource: PhotoSource.network,
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
          // photo:'https://drive.google.com/uc?export=view&id=146yEFbnwNDDyoVCHyOx-_oxxmCsrd8Rv',
          photoSource: PhotoSource.network,
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
          // photo:'https://drive.google.com/uc?export=view&id=1gZH76loV7uc7J_3hNUkudETuyyBQGBXI',
          photoSource: PhotoSource.network,
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
          photo: Base64Cola.colaBase64,
          photoSource: PhotoSource.file,
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
          photo: Base64Cola.cola6Base64,
          photoSource: PhotoSource.file,
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
          photo: cola100Base64,
          photoSource: PhotoSource.memory,
          creationDate: WeebiDates.defaultDate,
        ),
      ],
    ),
  ];
}

const cola100Base64 = '/9'; // will fail to check that error image is displayed
