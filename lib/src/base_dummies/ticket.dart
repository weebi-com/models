import 'package:models_weebi/src/base/ticket_base.dart';
import 'package:models_weebi/src/common/paiement_type.dart';
import 'package:models_weebi/src/common/ticket_type.dart';
import 'package:models_weebi/src/base_dummies/item.dart';
import 'package:models_weebi/src/base_dummies/taxe.dart';
import 'package:models_weebi/src/utils/dates.dart';

class TicketDummy extends TicketAbstract {
  TicketDummy()
      : super(
          id: 1,
          shopUuid: '0',
          items: [ItemDummy()],
          taxe: TaxDummy(),
          promo: 0.0,
          comment: 'comment',
          received: 0,
          herderIdString: '1',
          date: WeebiDates.defaultDate,
          paiementType: PaiementType.nope,
          ticketType: TicketType.stockOut,
          status: true,
          statusUpdateDate: WeebiDates.defaultDate,
          creationDate: WeebiDates.defaultDate,
        );
}
