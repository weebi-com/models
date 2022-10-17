import 'package:models_base/common.dart';
import 'package:models_base/utils.dart';
import 'package:models_weebi/src/models/line_of_articles_w.dart';
import 'package:models_weebi/src/models/ticket_weebi_abstract.dart';

mixin TicketPrinter on TicketWeebiAbstract {
  // -----STRINGS-----
  String get titleSell {
    final sb = StringBuffer(numFormat.format(totalSellTaxAndPromoIncluded))
      ..write(' ');
    sb.write(PaiementType.paiementString(paiementType));
    return sb.toString();
  }

  String get titleSellCovered {
    final sb = StringBuffer(numFormat.format((received)))..write(' ');
    sb.write(PaiementType.paiementString(paiementType));
    return sb.toString();
  }

  String get titleSellDeferred {
    final sb =
        StringBuffer(numFormat.format(totalSellDeferredTaxAndPromoIncluded))
          ..write(' ');
    sb.write(PaiementType.paiementString(paiementType));
    return sb.toString();
  }

  String get titleSpend {
    final sb = StringBuffer(numFormat.format(totalSpendTaxAndPromoIncluded))
      ..write(' ');
    sb.write(PaiementType.paiementString(paiementType));
    return sb.toString();
  }

  String get titleSpendCovered {
    final sb = StringBuffer(numFormat.format((received)))..write(' ');
    sb.write(PaiementType.paiementString(paiementType));
    return sb.toString();
  }

  String get titleSpendDeferred {
    final sb =
        StringBuffer(numFormat.format(totalSpendDeferredTaxAndPromoIncluded))
          ..write(' ');
    sb.write(PaiementType.paiementString(paiementType));
    return sb.toString();
  }

  String getSharableTextLight(Iterable<LineOfArticles> lines) {
    final products = StringBuffer();
    for (var item in items) {
      final _price = item.getArticlePrice(lines);
      products.write(
          '${item.quantity}x ${item.article.fullName} $_price = ${item.getTotalPrice(lines)}');
    }
    final sb = StringBuffer()
      ..writeln('#$id')
      ..writeln('#$shopUuid')
      ..writeln(date)
      ..writeln('type: ${TicketType.typeString(ticketType)}')
      ..writeln(products.toString())
      ..writeln('paiement: ${PaiementType.paiementString(paiementType)}')
      ..writeln('taxes: $totalSellTaxes')
      ..writeln('total: $totalSellTaxAndPromoIncluded')
      ..writeln('contact: $herderId')
      ..writeln(deactivatedDate);
    return sb.toString();
  }

  // ToRuminate - consider splitting this to avoid passing lines if no basket
  String getSharableText(Iterable<LineOfArticles> lines) {
    final products = StringBuffer();
    for (final item in items) {
      final _price = item.getArticlePrice(lines);
      products.write(
          '${item.quantity}x ${item.article.fullName} $_price = ${item.getTotalPrice(lines)}');
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
        ..writeln('total : ${numFormat.format(totalSellTaxAndPromoExcluded)}')
        ..writeln('- ${numFormat.format(totalSellPromo)} (promo $promo%)')
        ..writeln(
            'total HT : ${numFormat.format(totalSellTaxExcludedIncludingPromo)}')
        ..writeln(
            '+ taxe : ${numFormat.format(totalSellTaxes)} (taxe ${taxe.percentage} %)')
        ..writeln(
            'total TTC : ${numFormat.format(totalSellTaxAndPromoIncluded)}')
        ..writeln(
            'monnaie : ${numFormat.format(received - totalSellTaxAndPromoIncluded)}')
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
        ..writeln('total : ${numFormat.format(totalSpendTaxAndPromoExcluded)}')
        ..writeln('- ${numFormat.format(totalSpendPromo)} (promo $promo %)')
        ..writeln(
            'total HT : ${numFormat.format(totalSpendTaxExcludedIncludingPromo)}')
        ..writeln(
            '+ taxe : ${numFormat.format(totalSpendTaxes)} (taxe ${taxe.percentage} %)')
        ..writeln(
            'total TTC : ${numFormat.format(totalSpendTaxAndPromoIncluded)}')
        ..writeln(
            'monnaie : ${numFormat.format(received - totalSpendTaxAndPromoIncluded)}')
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
        ..writeln(
            'total : ${numFormat.format(totalSellDeferredTaxAndPromoExcluded)}')
        ..writeln(
            '- ${numFormat.format(totalSellDeferredPromo)} (promo $promo%)')
        ..writeln(
            'total HT : ${numFormat.format(totalSellDeferredTaxExcludedPromoIncluded)}')
        ..writeln(
            '+ taxe : ${numFormat.format(totalSellDeferredTaxes)} (taxe ${taxe.percentage} %)')
        ..writeln(
            'total TTC : ${numFormat.format(totalSellDeferredTaxAndPromoIncluded)}')
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
        ..writeln(
            'total : ${numFormat.format(totalSpendDeferredTaxAndPromoExcluded)}')
        ..writeln(
            '- ${numFormat.format(totalSpendDeferredPromo)} (promo $promo %)')
        ..writeln(
            'total HT : ${numFormat.format(totalSpendTaxExcludedIncludingPromo)}')
        ..writeln(
            '+ taxe : ${numFormat.format(totalSpendTaxes)} (taxe ${taxe.percentage} %)')
        ..writeln(
            'total TTC : ${numFormat.format(totalSpendDeferredTaxAndPromoIncluded)}')
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
