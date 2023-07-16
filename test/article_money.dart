import 'package:models_weebi/src/models/price_and_cost.dart';
import 'package:models_weebi/weebi_models.dart';
// import 'package:money2/money2.dart';
import 'package:test/test.dart';

// reactivate when
// String priceCurrencyString({String code = ''}) {
//   if (code == '') {
//     return priceClean.toString();
//   } else {
//     return Money.fromNum(price, code: code).toString();
//   }
// }

// String costCurrencyString({String code = ''}) {
//   if (code == '') {
//     return costClean.toString();
//   } else {
//     return Money.fromNum(cost, code: code).toString();
//   }
// }

// final Currency xof = Currency.create('XOF', 0,
//     symbol: 'f',
//     country: 'Afrique Ouest Francophone',
//     unit: 'Franc',
//     name: 'Franc CFA');

void main() {
  group('article money', () {
    test('toString rounding 4 decimals', () {
      final usd = 10.15;
      final usd2 = 10.10;
      final usd3 = 10;
      final clp = 10.1514; // chilean peso
      final clp2 = 10.1000;
      final stuff = 10.101;
      final annoyingConversion = 10.10009;
      expect(Price(usd).toString(), '10.15');
      expect(Price(usd2).toString(), '10.1');
      expect(Price(usd3).toString(), '10');
      expect(Price(stuff).toString(), '10.101');
      expect(Price(clp).toString(), '10.1514');
      expect(Price(clp2).toString(), '10.1');
      expect(Price(annoyingConversion).toString(), '10.1001');
    });

    // test('money displayed', () {
    //   final article3 = ArticleRetail.dummy.copyWith(price: 5.5001);
    //   expect(article3.priceCurrencyString(), '5.5001');
    //   final article = ArticleRetail.dummy.copyWith(price: 5.5);
    //   expect(article.priceCurrencyString(code: 'EUR'), '5,50€');
    //   expect(article.priceCurrencyString(), '5.5');
    //   final article2 = ArticleRetail.dummy.copyWith(price: 5.50000001);
    //   expect(article2.priceCurrencyString(), '5.5');
    // });

    test('article ret. with decimal price', () {
      final a = ArticleRetail.dummy.copyWith(price: 5.5);
      final json = a.toJson();
      final dummy = ArticleRetail.fromJson(json);
      expect(dummy.price, 5.5);

      final a2 = ArticleRetail.dummy.copyWith(price: 5.50000001);
      final json2 = a2.toJson();
      final dummy2 = ArticleRetail.fromJson(json2);
      expect(dummy2.price, 5.5);

      final a3 = ArticleRetail.dummy.copyWith(price: 5.5001);
      final json3 = a3.toJson();
      final dummy3 = ArticleRetail.fromJson(json3);
      expect(dummy3.price, 5.5001);
    });
  });
}
