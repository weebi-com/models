import 'package:models_weebi/common.dart';
import 'package:models_weebi/utils.dart';
import 'package:models_weebi/weebi_models.dart';
// import 'package:models_weebi/src/models/item_weebi.dart';
// import 'package:models_weebi/src/models/taxe_weebi.dart';

mixin TicketMixinWeebiBase on TicketWeebiAbstract {
  num calculateSumsOfTicket(
      TicketType ticketType, DateTime startOfMonth, DateTime endOfMonth) {
    if (ticketType == ticketType &&
        date.isAfter(startOfMonth) &&
        date.isBefore(endOfMonth)) {
      switch (ticketType) {
        case TicketType.sell:
          return totalPriceTaxAndPromoIncluded;
        case TicketType.sellDeferred:
          return totalPriceTaxAndPromoIncluded;
        case TicketType.sellCovered:
          return received;
        case TicketType.spend:
          return totalCostTaxAndPromoIncluded;
        case TicketType.spendDeferred:
          return totalCostTaxAndPromoIncluded;
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
      return numFormat.format(totalPriceItemsOnly);
    } else if (ticketType == TicketType.sellDeferred) {
      return numFormat.format(totalPriceItemsOnly);
    } else if (ticketType == TicketType.sellCovered) {
      return numFormat.format(received);
    } else if (ticketType == TicketType.spend) {
      return numFormat.format(totalCostItemsOnly);
    } else if (ticketType == TicketType.spendDeferred) {
      return numFormat.format(totalCostItemsOnly);
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
      return numFormat.format(totalPriceTaxAndPromoIncluded);
    } else if (ticketType == TicketType.sellDeferred) {
      return numFormat.format(totalPriceTaxAndPromoIncluded);
    } else if (ticketType == TicketType.sellCovered) {
      return numFormat.format(received);
    } else if (ticketType == TicketType.spend) {
      return numFormat.format(totalCostTaxAndPromoIncluded);
    } else if (ticketType == TicketType.spendDeferred) {
      return numFormat.format(totalCostTaxAndPromoIncluded);
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
      return '- ${numFormat.format(totalPricePromoVal)}';
    } else if (ticketType == TicketType.sellDeferred) {
      return '- ${numFormat.format(totalPricePromoVal)}';
    } else if (ticketType == TicketType.sellCovered) {
      return '- ${numFormat.format(promo)}';
    } else if (ticketType == TicketType.spend) {
      return '- ${numFormat.format(totalCostPromoVal)}';
    } else if (ticketType == TicketType.spendDeferred) {
      return '- ${numFormat.format(totalCostPromoVal)}';
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
      return numFormat.format(totalPriceTaxExcludedPromoIncluded);
    } else if (ticketType == TicketType.sellDeferred) {
      return numFormat.format(totalPriceTaxExcludedPromoIncluded);
    } else if (ticketType == TicketType.sellCovered) {
      return numFormat.format(received);
    } else if (ticketType == TicketType.spend) {
      return numFormat.format(totalCostTaxExcludedIncludingPromo);
    } else if (ticketType == TicketType.spendDeferred) {
      return numFormat.format(totalCostTaxExcludedIncludingPromo);
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
      return '+ ${numFormat.format(totalPriceTaxesVal)}';
    } else if (ticketType == TicketType.sellDeferred) {
      return '+ ${numFormat.format(totalPriceTaxesVal)}';
    } else if (ticketType == TicketType.sellCovered) {
      return '+ ${numFormat.format(taxe)}';
    } else if (ticketType == TicketType.spend) {
      return '+ ${numFormat.format(totalCostTaxesVal)}';
    } else if (ticketType == TicketType.spendDeferred) {
      return '+ ${numFormat.format(totalCostTaxesVal)}';
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
      return numFormat.format(received - totalPriceTaxAndPromoIncluded);
    } else if (ticketType == TicketType.sellDeferred) {
      return '0';
    } else if (ticketType == TicketType.sellCovered) {
      return '0';
    } else if (ticketType == TicketType.spend) {
      return numFormat.format(received - totalCostTaxAndPromoIncluded);
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

  num get sellFull {
    switch (ticketType) {
      case TicketType.sell:
        return totalPriceTaxAndPromoIncluded;
      // case TicketType.sellDeferred:
      //   return totalSellDeferredTtc;
      case TicketType.sellCovered:
        return received;
      default:
        return 0;
    }
  }

  num get spendFull {
    switch (ticketType) {
      case TicketType.spend:
        return totalCostTaxAndPromoIncluded;
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
