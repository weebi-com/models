import 'package:models_base/common.dart';
import 'package:models_base/utils.dart';
import 'package:models_weebi/weebi_models.dart';
// import 'package:models_weebi/src/models/item_weebi.dart';
// import 'package:models_weebi/src/models/taxe_weebi.dart';

mixin TicketMixinWeebiBase on TicketWeebiAbstract {
  int calculateSumsOfTicket(
      TicketType _ticketType, DateTime startOfMonth, DateTime endOfMonth) {
    if (ticketType == _ticketType &&
        date.isAfter(startOfMonth) &&
        date.isBefore(endOfMonth)) {
      switch (_ticketType) {
        case TicketType.sell:
          return totalSellTaxAndPromoIncluded;
        case TicketType.sellDeferred:
          return totalSellDeferredTaxAndPromoIncluded;
        case TicketType.sellCovered:
          return received;
        case TicketType.spend:
          return totalSpendTaxAndPromoIncluded;
        case TicketType.spendDeferred:
          return totalSpendDeferredTaxAndPromoIncluded;
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
      return numFormat.format(totalSellTaxAndPromoExcluded);
    } else if (ticketType == TicketType.sellDeferred) {
      return numFormat.format(totalSellDeferredTaxAndPromoExcluded);
    } else if (ticketType == TicketType.sellCovered) {
      return numFormat.format(received);
    } else if (ticketType == TicketType.spend) {
      return numFormat.format(totalSpendTaxAndPromoExcluded);
    } else if (ticketType == TicketType.spendDeferred) {
      return numFormat.format(totalSpendDeferredTaxAndPromoExcluded);
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
      return numFormat.format(totalSellTaxAndPromoIncluded);
    } else if (ticketType == TicketType.sellDeferred) {
      return numFormat.format(totalSellDeferredTaxAndPromoIncluded);
    } else if (ticketType == TicketType.sellCovered) {
      return numFormat.format(received);
    } else if (ticketType == TicketType.spend) {
      return numFormat.format(totalSpendTaxAndPromoIncluded);
    } else if (ticketType == TicketType.spendDeferred) {
      return numFormat.format(totalSpendDeferredTaxAndPromoIncluded);
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
      return numFormat.format(totalSellTaxExcludedIncludingPromo);
    } else if (ticketType == TicketType.sellDeferred) {
      return numFormat.format(totalSellDeferredTaxExcludedPromoIncluded);
    } else if (ticketType == TicketType.sellCovered) {
      return numFormat.format(received);
    } else if (ticketType == TicketType.spend) {
      return numFormat.format(totalSpendTaxExcludedIncludingPromo);
    } else if (ticketType == TicketType.spendDeferred) {
      return numFormat.format(totalSpendDeferredTaxExcludedIncludingPromo);
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
      return numFormat.format(received - totalSellTaxAndPromoIncluded);
    } else if (ticketType == TicketType.sellDeferred) {
      return '0';
    } else if (ticketType == TicketType.sellCovered) {
      return '0';
    } else if (ticketType == TicketType.spend) {
      return numFormat.format(received - totalSpendTaxAndPromoIncluded);
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

  int get sellFull {
    switch (ticketType) {
      case TicketType.sell:
        return totalSellTaxAndPromoIncluded;
      // case TicketType.sellDeferred:
      //   return totalSellDeferredTtc;
      case TicketType.sellCovered:
        return received;
      default:
        return 0;
    }
  }

  int get spendFull {
    switch (ticketType) {
      case TicketType.spend:
        return totalSpendTaxAndPromoIncluded;
      // case TicketType.spendDeferred:
      //   return totalSpendDeferredTtc;
      case TicketType.spendCovered:
        return received;
      case TicketType.unknown:
        print('unknow ticket type in calculateSumsOfTicket');
        return 0;
      default:
        return 0;
    }
  }
}
