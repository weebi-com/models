import 'package:models_base/common.dart';
import 'package:weebi_models/src/weebi/article_weebi.dart';
import 'package:weebi_models/src/weebi/product_weebi.dart';
import 'package:weebi_models/weebi_models.dart';

void main() {
  var awesomeProduct = ProductWeebi(
    articles: [
      ArticleWeebi(
        productId: 1,
        id: 1,
        fullName: 'frometon',
        price: 100,
      )
    ],
    id: 1,
    title: 'frometon',
    status: true,
    creationDate: defaultDate,
  );

  final awesomeTicket = TicketWeebi(
    oid: 'oid',
    id: 1,
    shopId: 'shopId',
    items: [],
    taxe: TaxeWeebi.noTax,
    promo: 0.0,
    comment: '',
    received: 0,
    date: defaultDate,
    paiementType: PaiementType.cash,
    ticketType: TicketType.sell,
    contactInfo: '1',
    contactPastPurchasingPower: '0',
    status: true,
    statusUpdateDate: defaultDate,
    creationDate: defaultDate,
  );
}
