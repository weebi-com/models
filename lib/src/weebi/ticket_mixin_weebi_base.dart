import 'package:models_base/base.dart'
    show ItemInCartAbstract, TaxeAbstract, TicketAbstract;
import 'package:models_base/common.dart';
import 'package:models_base/utils.dart';
// import 'package:models_weebi/src/weebi/item_weebi.dart';
// import 'package:models_weebi/src/weebi/taxe_weebi.dart';

mixin TicketMixinWeebiBase on TicketAbstract<ItemInCartAbstract, TaxeAbstract> {
  int calculateSumsOfTicket(
      TicketType _ticketType, DateTime startOfMonth, DateTime endOfMonth) {
    if (ticketType == _ticketType &&
        date.isAfter(startOfMonth) &&
        date.isBefore(endOfMonth)) {
      switch (_ticketType) {
        case TicketType.sell:
          return totalSellTtc;
        case TicketType.sellDeferred:
          return totalSellDeferredTtc;
        case TicketType.sellCovered:
          return received;
        case TicketType.spend:
          return totalSpendTtc;
        case TicketType.spendDeferred:
          return totalSpendDeferredTtc;
        case TicketType.spendCovered:
          return received;
        case TicketType.wage:
          return received;
        case TicketType.unknown:
          print('unknow ticket type in calculateSumsOfTicket');
          return 0;
        default:
          return 0;
      }
    } else {
      return 0;
    }
  }

  double soldQtByArticle(
      String articleName, DateTime startOfMonth, DateTime endOfMonth) {
    double qty = 0;
    if (ticketType == TicketType.sell ||
        ticketType == TicketType.sellDeferred) {
      if (date.isAfter(startOfMonth) && date.isBefore(endOfMonth)) {
        for (var item in items) {
          if (item.article.fullName == articleName) {
            qty += item.quantity;
          }
        }
      }
    }
    return qty;
  }

  String get totalHtFormattedString {
    if (ticketType == TicketType.sell) {
      return numFormat.format(totalSell);
    } else if (ticketType == TicketType.sellDeferred) {
      return numFormat.format(totalSellDeferredHt);
    } else if (ticketType == TicketType.sellCovered) {
      return numFormat.format(received);
    } else if (ticketType == TicketType.spend) {
      return numFormat.format(totalSpend);
    } else if (ticketType == TicketType.spendDeferred) {
      return numFormat.format(totalSpendDeferredHt);
    } else if (ticketType == TicketType.spendCovered) {
      return numFormat.format(received);
    } else if (ticketType == TicketType.stockIn) {
      return '0';
    } else if (ticketType == TicketType.stockOut) {
      return '0';
    } else if (ticketType == TicketType.wage) {
      return numFormat.format(received);
    } else {
      return 'Type de ticket inconnu';
    }
  }

  String get totalTtcFormattedString {
    if (ticketType == TicketType.sell) {
      return numFormat.format(totalSellTtc);
    } else if (ticketType == TicketType.sellDeferred) {
      return numFormat.format(totalSellDeferredTtc);
    } else if (ticketType == TicketType.sellCovered) {
      return numFormat.format(received);
    } else if (ticketType == TicketType.spend) {
      return numFormat.format(totalSpendTtc);
    } else if (ticketType == TicketType.spendDeferred) {
      return numFormat.format(totalSpendDeferredTtc);
    } else if (ticketType == TicketType.spendCovered) {
      return numFormat.format(received);
    } else if (ticketType == TicketType.stockIn) {
      return ''; // doublecheck this
    } else if (ticketType == TicketType.stockOut) {
      return ''; // doublecheck this
    } else if (ticketType == TicketType.wage) {
      return numFormat.format(received);
    } else {
      return 'Type de ticket inconnu';
    }
  }

  String get getTicketPromoString {
    if (ticketType == TicketType.sell) {
      return '- ${numFormat.format(totalSellPromo)}';
    } else if (ticketType == TicketType.sellDeferred) {
      return '- ${numFormat.format(totalSellDeferredPromo)}';
    } else if (ticketType == TicketType.sellCovered) {
      return '- ${numFormat.format(promo)}';
    } else if (ticketType == TicketType.spend) {
      return '- ${numFormat.format(totalSpendPromo)}';
    } else if (ticketType == TicketType.spendDeferred) {
      return '- ${numFormat.format(totalSpendDeferredPromo)}';
    } else if (ticketType == TicketType.spendCovered) {
      return '- ${numFormat.format(promo)}';
    } else if (ticketType == TicketType.stockIn) {
      return '0'; // doublecheck this
    } else if (ticketType == TicketType.stockOut) {
      return '0'; // doublecheck this
    } else {
      return 'Type de ticket inconnu';
    }
  }

  String get getTicketHtIncludingPromo {
    if (ticketType == TicketType.sell) {
      return numFormat.format(totalSellHtIncludingPromo);
    } else if (ticketType == TicketType.sellDeferred) {
      return numFormat.format(totalSellDeferredHtIncludingPromo);
    } else if (ticketType == TicketType.sellCovered) {
      return numFormat.format(received);
    } else if (ticketType == TicketType.spend) {
      return numFormat.format(totalSpendHtIncludingPromo);
    } else if (ticketType == TicketType.spendDeferred) {
      return numFormat.format(totalSpendDeferredHtIncludingPromo);
    } else if (ticketType == TicketType.spendCovered) {
      return numFormat.format(received);
    } else if (ticketType == TicketType.stockIn) {
      return '0';
    } else if (ticketType == TicketType.stockOut) {
      return '0';
    } else if (ticketType == TicketType.wage) {
      return numFormat.format(received);
    } else {
      return 'Type de ticket inconnu';
    }
  }

  String get getTicketTotalTaxes {
    if (ticketType == TicketType.sell) {
      return '+ ${numFormat.format(totalSellTaxes)}';
    } else if (ticketType == TicketType.sellDeferred) {
      return '+ ${numFormat.format(totalSellDeferredTaxes)}';
    } else if (ticketType == TicketType.sellCovered) {
      return '+ ${numFormat.format(taxe)}';
    } else if (ticketType == TicketType.spend) {
      return '+ ${numFormat.format(totalSpendTaxes)}';
    } else if (ticketType == TicketType.spendDeferred) {
      return '+ ${numFormat.format(totalSpendDeferredTaxes)}';
    } else if (ticketType == TicketType.spendCovered) {
      return '+ ${numFormat.format(taxe)}';
    } else if (ticketType == TicketType.stockIn) {
      return '0';
    } else if (ticketType == TicketType.stockOut) {
      return '0'; // doublecheck this
    } else {
      return 'ticketType inconnu';
    }
  }

  String get getTicketChange {
    if (ticketType == TicketType.sell) {
      return numFormat.format(received - totalSellTtc);
    } else if (ticketType == TicketType.sellDeferred) {
      return '0';
    } else if (ticketType == TicketType.sellCovered) {
      return '0';
    } else if (ticketType == TicketType.spend) {
      return numFormat.format(received - totalSpendTtc);
    } else if (ticketType == TicketType.spendDeferred) {
      return '0';
    } else if (ticketType == TicketType.spendCovered) {
      return '0'; // doublecheck this
    } else if (ticketType == TicketType.stockIn) {
      return '0'; // doublecheck this
    } else if (ticketType == TicketType.stockOut) {
      return '0'; // doublecheck this
    } else if (ticketType == TicketType.wage) {
      return ''; // doublecheck this
    } else {
      return 'Type de ticket inconnu';
    }
  }
}
