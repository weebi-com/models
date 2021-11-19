import 'package:models_base/common.dart';
import 'package:weebi_models/src/weebi/ticket_weebi_abstract.dart';

mixin TicketPrinter on TicketWeebiAbstract {
  // -----STRINGS-----
  String get titleSell {
    final sb = StringBuffer(numFormat.format(totalSellTtc))..write(' ');
    sb.write(PaiementType.paiementString(paiementType));
    return sb.toString();
  }

  String get titleSellCovered {
    final sb = StringBuffer(numFormat.format((received)))..write(' ');
    sb.write(PaiementType.paiementString(paiementType));
    return sb.toString();
  }

  String get titleSellDeferred {
    final sb = StringBuffer(numFormat.format(totalSellDeferredTtc))..write(' ');
    sb.write(PaiementType.paiementString(paiementType));
    return sb.toString();
  }

  String get titleSpend {
    final sb = StringBuffer(numFormat.format(totalSpendTtc))..write(' ');
    sb.write(PaiementType.paiementString(paiementType));
    return sb.toString();
  }

  String get titleSpendCovered {
    final sb = StringBuffer(numFormat.format((received)))..write(' ');
    sb.write(PaiementType.paiementString(paiementType));
    return sb.toString();
  }

  String get titleSpendDeferred {
    final sb = StringBuffer(numFormat.format(totalSpendDeferredTtc))
      ..write(' ');
    sb.write(PaiementType.paiementString(paiementType));
    return sb.toString();
  }

  String get sharableTextLight {
    final products = StringBuffer();
    for (var item in items) {
      products.write(
          '${item.quantity}x ${item.article.fullName} ${item.article.price} : ${(item.article.price) * (item.quantity)}');
    }
    final sb = StringBuffer()
      ..writeln('#$id')
      ..writeln('#$shopUuid')
      ..writeln(date)
      ..writeln('type: ${TicketType.typeString(ticketType)}')
      ..writeln(products.toString())
      ..writeln('paiement: ${PaiementType.paiementString(paiementType)}')
      ..writeln('taxes: $totalSellTaxes')
      ..writeln('total: $totalSellTtc')
      ..writeln('contact: $herderId')
      ..writeln(deactivatedDate);
    return sb.toString();
  }

  String get sharableText {
    final products = StringBuffer();
    items.forEach((item) {
      products.write(
          '${item.quantity}x ${item.article.fullName} ${item.article.price} : ${numFormat.format(item.article.price * item.quantity)}');
    });
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
        ..writeln('total : ${numFormat.format(totalSell)}')
        ..writeln('- ${numFormat.format(totalSellPromo)} (promo $promo%)')
        ..writeln('total HT : ${numFormat.format(totalSellHtIncludingPromo)}')
        ..writeln(
            '+ taxe : ${numFormat.format(totalSellTaxes)} (taxe ${taxe.percentage} %)')
        ..writeln('total TTC : ${numFormat.format(totalSellTtc)}')
        ..writeln('monnaie : ${numFormat.format(received - totalSellTtc)}')
        ..writeln('note : $comment')
        ..writeln('$deactivatedDate')
        ..writeln('')
        ..writeln('contact : $contactInfo');
      return sb.toString();
    } else if (ticketType == TicketType.spend) {
      final sb = StringBuffer()
        ..writeln('$shopId')
        ..writeln('ticket # $id')
        ..writeln(
            'date : ${date.year}_${date.month}_${date.day} ${date.hour}:${date.minute}:${date.second}')
        ..writeln('type : $type')
        ..writeln('paiement : $paiement')
        ..writeln(products.toString())
        ..writeln('')
        ..writeln('total : ${numFormat.format(totalSpend)}')
        ..writeln('- ${numFormat.format(totalSpendPromo)} (promo $promo %)')
        ..writeln('total HT : ${numFormat.format(totalSpendHtIncludingPromo)}')
        ..writeln(
            '+ taxe : ${numFormat.format(totalSpendTaxes)} (taxe ${taxe.percentage} %)')
        ..writeln('total TTC : ${numFormat.format(totalSpendTtc)}')
        ..writeln('monnaie : ${numFormat.format(received - totalSpendTtc)}')
        ..writeln('note : $comment')
        ..writeln('$deactivatedDate')
        ..writeln('')
        ..writeln('contact : $contactInfo');
      return sb.toString();
    } else if (ticketType == TicketType.sellCovered) {
      final sb = StringBuffer()
        ..writeln('$shopId')
        ..writeln('ticket # $id')
        ..writeln(
            'date : ${date.year}_${date.month}_${date.day} ${date.hour}:${date.minute}:${date.second}')
        ..writeln('paiement : $paiement')
        ..writeln('type : $type')
        ..writeln('versé : ${numFormat.format(received)}')
        ..writeln('note : $comment')
        ..writeln('$deactivatedDate')
        ..writeln('')
        ..writeln('client : $contactInfo')
        ..writeln(
            'solde avant : ${numFormat?.format(contactPastPurchasingPower)}');
      return sb.toString();
    } else if (ticketType == TicketType.spendCovered) {
      final sb = StringBuffer()
        ..writeln('$shopId')
        ..writeln('ticket # $id')
        ..writeln(
            'date : ${date.year}_${date.month}_${date.day} ${date.hour}:${date.minute}:${date.second}')
        ..writeln('paiement : $paiement')
        ..writeln('type : $type')
        ..writeln('versé : ${numFormat.format(received)}')
        ..writeln('note : $comment')
        ..writeln('$deactivatedDate')
        ..writeln('')
        ..writeln('fournisseur : $contactInfo')
        ..writeln(
            'solde avant : ${numFormat?.format(contactPastPurchasingPower)}');
      return sb.toString();
    } else if (ticketType == TicketType.sellDeferred) {
      final sb = StringBuffer()
        ..writeln('$shopId')
        ..writeln('ticket # $id')
        ..writeln(
            'date : ${date.year}_${date.month}_${date.day} ${date.hour}:${date.minute}:${date.second}')
        ..writeln('type : $type')
        ..writeln('paiement : $paiement')
        ..writeln(products.toString())
        ..writeln('')
        ..writeln('total : ${numFormat.format(totalSellDeferredHt)}')
        ..writeln(
            '- ${numFormat.format(totalSellDeferredPromo)} (promo $promo%)')
        ..writeln(
            'total HT : ${numFormat.format(totalSellDeferredHtIncludingPromo)}')
        ..writeln(
            '+ taxe : ${numFormat.format(totalSellDeferredTaxes)} (taxe ${taxe.percentage} %)')
        ..writeln('total TTC : ${numFormat.format(totalSellDeferredTtc)}')
        ..writeln('note : $comment')
        ..writeln('$deactivatedDate')
        ..writeln('')
        ..writeln('client : $contactInfo')
        ..writeln(
            'solde avant : ${numFormat?.format(contactPastPurchasingPower)}');
      return sb.toString();
    } else if (ticketType == TicketType.spendDeferred) {
      final sb = StringBuffer()
        ..writeln('$shopId')
        ..writeln('ticket # $id')
        ..writeln(
            'date : ${date.year}_${date.month}_${date.day} ${date.hour}:${date.minute}:${date.second}')
        ..writeln('type : $type')
        ..writeln('paiement : $paiement')
        ..writeln(products.toString())
        ..writeln('')
        ..writeln('total : ${numFormat.format(totalSpendDeferredHt)}')
        ..writeln(
            '- ${numFormat.format(totalSpendDeferredPromo)} (promo $promo %)')
        ..writeln('total HT : ${numFormat.format(totalSpendHtIncludingPromo)}')
        ..writeln(
            '+ taxe : ${numFormat.format(totalSpendTaxes)} (taxe ${taxe.percentage} %)')
        ..writeln('total TTC : ${numFormat.format(totalSpendDeferredTtc)}')
        ..writeln('note : $comment')
        ..writeln('$deactivatedDate')
        ..writeln('')
        ..writeln('fournisseur : $contactInfo')
        ..writeln(
            'solde avant : ${numFormat?.format(contactPastPurchasingPower)}');
      return sb.toString();
    } else {
      final sb = StringBuffer()
        ..writeln('$shopId')
        ..writeln('ticket # $id')
        ..writeln(
            'date : ${date.year}_${date.month}_${date.day} ${date.hour}:${date.minute}:${date.second}')
        ..writeln('type : $type')
        ..writeln('paiement: ${PaiementType.paiementString(paiementType)}')
        ..writeln(products.toString())
        ..writeln('contact : $contactInfo')
        ..writeln('$deactivatedDate');
      return sb.toString();
    }
  }
}
