import 'package:models_common/common.dart';
import 'package:models_common/utils.dart';
import 'package:models_weebi/weebi_models.dart';
import 'package:models_weebi/src/weebi/article_weebi.dart';
import 'package:models_weebi/src/weebi/product_weebi.dart';

void main() {
  // var awesomeProduct =
  ProductWeebi(
    articles: [
      ArticleWeebi(
        shopUuid: 'unknown',
        productId: 1,
        id: 1,
        fullName: 'frometon',
        price: 100,
      )
    ],
    id: 1,
    title: 'frometon',
    status: true,
    creationDate: WeebiDates.defaultDate,
  );

  // final awesomeTicket =
  TicketWeebi(
    oid: 'oid',
    id: 1,
    shopId: 'shopId',
    items: [],
    taxe: TaxeWeebi.noTax,
    promo: 0.0,
    comment: '',
    received: 0,
    date: WeebiDates.defaultDate,
    paiementType: PaiementType.cash,
    ticketType: TicketType.sell,
    contactInfo: '1',
    contactPastPurchasingPower: '0',
    status: true,
    statusUpdateDate: WeebiDates.defaultDate,
    creationDate: WeebiDates.defaultDate,
  );
}
