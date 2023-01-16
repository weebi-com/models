import 'package:models_base/common.dart';
import 'package:models_base/utils.dart';
import 'package:models_weebi/src/models/line_of_articles_w.dart';
import 'package:models_weebi/src/models/ticket_weebi_abstract.dart';

mixin TicketPrinter on TicketWeebiAbstract {
  // -----STRINGS-----
  String get titleTotalPrice {
    final sb = StringBuffer(numFormat.format(totalPriceTaxAndPromoIncluded))
      ..write(' ');
    sb.write(PaiementType.paiementString(paiementType));
    return sb.toString();
  }

  String get titleSellCovered {
    final sb = StringBuffer(numFormat.format((received)))..write(' ');
    sb.write(PaiementType.paiementString(paiementType));
    return sb.toString();
  }

  String get titleTotalCost {
    final sb = StringBuffer(numFormat.format(totalCostTaxAndPromoIncluded))
      ..write(' ');
    sb.write(PaiementType.paiementString(paiementType));
    return sb.toString();
  }

  String get titleSpendCovered {
    final sb = StringBuffer(numFormat.format((received)))..write(' ');
    sb.write(PaiementType.paiementString(paiementType));
    return sb.toString();
  }

  String getSharableTextLight(Iterable<LineOfArticles> lines) {
    final products = StringBuffer();
    for (var item in items) {
      products.write(
          '${item.quantity}x ${item.article.fullName} ${item.articlePrice} = ${item.totalPrice}');
    }
    final sb = StringBuffer()
      ..writeln('#$id')
      ..writeln('#$shopUuid')
      ..writeln(date)
      ..writeln('type: ${TicketType.typeString(ticketType)}')
      ..writeln(products.toString())
      ..writeln('paiement: ${PaiementType.paiementString(paiementType)}')
      ..writeln('taxes: $totalPriceTaxesVal')
      ..writeln('total: $totalPriceTaxAndPromoIncluded')
      ..writeln('contact: $herderId')
      ..writeln(deactivatedDate);
    return sb.toString();
  }

  // ToRuminate - consider splitting this to avoid passing lines if no basket
  String getSharableText(Iterable<LineOfArticles> lines) {
    final products = StringBuffer();
    for (final item in items) {
      products.write(
          '${item.quantity}x ${item.article.fullName} ${item.articlePrice} = ${item.totalPrice}');
    }
    if (ticketType == TicketType.sell) {
      final sb = StringBuffer()
        ..writeln('#$shopId')
        ..writeln('ticket # $id')
        ..writeln(
            'date : ${date.year}_${date.month}_${date.day} ${date.hour}:${date.minute}:${date.second}')
        ..writeln('type: ${TicketType.typeString(ticketType)}')
        ..writeln('paiement : $paiement')
        ..writeln(products.toString())
        ..writeln('')
        ..writeln('total : ${numFormat.format(totalPriceItemsOnly)}')
        ..writeln('- ${numFormat.format(totalPricePromoVal)} (promo $promo%)')
        ..writeln(
            'total HT : ${numFormat.format(totalPriceTaxExcludedPromoIncluded)}')
        ..writeln(
            '+ taxe : ${numFormat.format(totalPriceTaxesVal)} (taxe ${taxe.percentage} %)')
        ..writeln(
            'total TTC : ${numFormat.format(totalPriceTaxAndPromoIncluded)}')
        ..writeln(
            'monnaie : ${numFormat.format(received - totalPriceTaxAndPromoIncluded)}')
        ..writeln('note : $comment')
        ..writeln(deactivatedDate)
        ..writeln('')
        ..writeln('contact : $contactInfo');
      return sb.toString();
    } else if (ticketType == TicketType.spend) {
      final sb = StringBuffer()
        ..writeln(shopId)
        ..writeln('ticket # $id')
        ..writeln(
            'date : ${date.year}_${date.month}_${date.day} ${date.hour}:${date.minute}:${date.second}')
        ..writeln('type : $type')
        ..writeln('paiement : $paiement')
        ..writeln(products.toString())
        ..writeln('')
        ..writeln('total : ${numFormat.format(totalCostItemsOnly)}')
        ..writeln('- ${numFormat.format(totalCostPromoVal)} (promo $promo %)')
        ..writeln(
            'total HT : ${numFormat.format(totalCostTaxExcludedIncludingPromo)}')
        ..writeln(
            '+ taxe : ${numFormat.format(totalCostTaxesVal)} (taxe ${taxe.percentage} %)')
        ..writeln(
            'total TTC : ${numFormat.format(totalCostTaxAndPromoIncluded)}')
        ..writeln(
            'monnaie : ${numFormat.format(received - totalCostTaxAndPromoIncluded)}')
        ..writeln('note : $comment')
        ..writeln(deactivatedDate)
        ..writeln('')
        ..writeln('contact : $contactInfo');
      return sb.toString();
    } else if (ticketType == TicketType.sellCovered) {
      final sb = StringBuffer()
        ..writeln(shopId)
        ..writeln('ticket # $id')
        ..writeln(
            'date : ${date.year}_${date.month}_${date.day} ${date.hour}:${date.minute}:${date.second}')
        ..writeln('paiement : $paiement')
        ..writeln('type : $type')
        ..writeln('versé : ${numFormat.format(received)}')
        ..writeln('note : $comment')
        ..writeln(deactivatedDate)
        ..writeln('')
        ..writeln('client : $contactInfo')
        ..writeln(
            'solde avant : ${numFormat.format(contactPastPurchasingPower)}');
      return sb.toString();
    } else if (ticketType == TicketType.spendCovered) {
      final sb = StringBuffer()
        ..writeln(shopId)
        ..writeln('ticket # $id')
        ..writeln(
            'date : ${date.year}_${date.month}_${date.day} ${date.hour}:${date.minute}:${date.second}')
        ..writeln('paiement : $paiement')
        ..writeln('type : $type')
        ..writeln('versé : ${numFormat.format(received)}')
        ..writeln('note : $comment')
        ..writeln(deactivatedDate)
        ..writeln('')
        ..writeln('fournisseur : $contactInfo')
        ..writeln(
            'solde avant : ${numFormat.format(contactPastPurchasingPower)}');
      return sb.toString();
    } else if (ticketType == TicketType.sellDeferred) {
      final sb = StringBuffer()
        ..writeln(shopId)
        ..writeln('ticket # $id')
        ..writeln(
            'date : ${date.year}_${date.month}_${date.day} ${date.hour}:${date.minute}:${date.second}')
        ..writeln('type : $type')
        ..writeln('paiement : $paiement')
        ..writeln(products.toString())
        ..writeln('')
        ..writeln('total : ${numFormat.format(totalPriceItemsOnly)}')
        ..writeln('- ${numFormat.format(totalPricePromoVal)} (promo $promo%)')
        ..writeln(
            'total HT : ${numFormat.format(totalPriceTaxExcludedPromoIncluded)}')
        ..writeln(
            '+ taxe : ${numFormat.format(totalPriceTaxesVal)} (taxe ${taxe.percentage} %)')
        ..writeln(
            'total TTC : ${numFormat.format(totalPriceTaxAndPromoIncluded)}')
        ..writeln('note : $comment')
        ..writeln(deactivatedDate)
        ..writeln('')
        ..writeln('client : $contactInfo')
        ..writeln(
            'solde avant : ${numFormat.format(contactPastPurchasingPower)}');
      return sb.toString();
    } else if (ticketType == TicketType.spendDeferred) {
      final sb = StringBuffer()
        ..writeln(shopId)
        ..writeln('ticket # $id')
        ..writeln(
            'date : ${date.year}_${date.month}_${date.day} ${date.hour}:${date.minute}:${date.second}')
        ..writeln('type : $type')
        ..writeln('paiement : $paiement')
        ..writeln(products.toString())
        ..writeln('')
        ..writeln('total : ${numFormat.format(totalCostItemsOnly)}')
        ..writeln('- ${numFormat.format(totalCostPromoVal)} (promo $promo %)')
        ..writeln(
            'total HT : ${numFormat.format(totalCostTaxExcludedIncludingPromo)}')
        ..writeln(
            '+ taxe : ${numFormat.format(totalCostTaxesVal)} (taxe ${taxe.percentage} %)')
        ..writeln(
            'total TTC : ${numFormat.format(totalCostTaxAndPromoIncluded)}')
        ..writeln('note : $comment')
        ..writeln(deactivatedDate)
        ..writeln('')
        ..writeln('fournisseur : $contactInfo')
        ..writeln(
            'solde avant : ${numFormat.format(contactPastPurchasingPower)}');
      return sb.toString();
    } else {
      final sb = StringBuffer()
        ..writeln(shopId)
        ..writeln('ticket # $id')
        ..writeln(
            'date : ${date.year}_${date.month}_${date.day} ${date.hour}:${date.minute}:${date.second}')
        ..writeln('type : $type')
        ..writeln('paiement: ${PaiementType.paiementString(paiementType)}')
        ..writeln(products.toString())
        ..writeln('contact : $contactInfo')
        ..writeln(deactivatedDate);
      return sb.toString();
    }
  }
}
