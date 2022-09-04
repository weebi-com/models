import 'package:models_base/common.dart';
import 'package:models_base/utils.dart';
import 'package:models_weebi/weebi_models.dart';

void main() {
  final awesomeArticleLine = LineOfArticlesWeebi(
    articles: [
      ArticleWeebi(
        shopUuid: 'unknown',
        lineId: 1,
        id: 1,
        fullName: 'frometon',
        price: 100,
        creationDate: WeebiDates.defaultDate,
        updateDate: WeebiDates.defaultDate,
      )
    ],
    id: 1,
    title: 'frometon',
    shopUuid: 'shopUuid',
    status: true,
    creationDate: WeebiDates.defaultDate,
    updateDate: WeebiDates.defaultDate,
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
  print(awesomeArticleLine);
}
