import 'package:models_weebi/common.dart';
import 'package:models_weebi/src/models/article_calibre.dart';
import 'package:models_weebi/src/models/ticket_weebi_abstract.dart';
import 'package:models_weebi/utils.dart';
import 'package:models_weebi/weebi_models.dart';

mixin TicketPrinter on TicketWeebiAbstract {
  // -----STRINGS-----
  String get titleTotalPrice {
    final sb = StringBuffer(numFormat.format(totalPriceTaxAndPromoIncluded))
      ..write(' ');
    sb.write(paiementType.paiementString);
    return sb.toString();
  }

  String get titleSellCovered {
    final sb = StringBuffer(numFormat.format((received)))..write(' ');
    sb.write(paiementType.paiementString);
    return sb.toString();
  }

  String get titleTotalCost {
    final sb = StringBuffer(numFormat.format(totalCostTaxAndPromoIncluded))
      ..write(' ');
    sb.write(paiementType.paiementString);
    return sb.toString();
  }

  String get titleSpendCovered {
    final sb = StringBuffer(numFormat.format((received)))..write(' ');
    sb.write(paiementType.paiementString);
    return sb.toString();
  }

  String getSharableTextLight(Iterable<ArticleCalibre> lines, Herder herder) {
    final products = StringBuffer();
    for (var item in items) {
      products.writeln(
          '${item.quantity}x ${item.article.fullName} ${item.articlePrice} = ${item.totalPrice}');
    }
    final sbHerder = StringBuffer();
    if (herder.id == 0 || herder == Herder.defaultHerder) {
      sbHerder.writeln('contact: inconnu');
    } else {
      sbHerder.writeln('contact: ${herder.fullName}');

      if (herder.tel.isNotEmpty) {
        sbHerder.writeln('contact tel: ${herder.tel}');
      }
      if (herder.mail.isNotEmpty) {
        sbHerder.writeln('contact mail: ${herder.mail}');
      }
      if (herder.address.isNotEmpty) {
        sbHerder.writeln('contact address: ${herder.address}');
      }
    }
    final sb = StringBuffer()
      ..writeln('#$id')
      ..writeln('#$shopUuid')
      ..writeln(date)
      ..writeln('type: ${ticketType.typeString}')
      ..writeln(products.toString())
      ..writeln('paiement: ${paiementType.paiementString}')
      ..writeln('taxes: $totalPriceTaxesVal')
      ..writeln('total: $totalPriceTaxAndPromoIncluded')
      ..write(sbHerder)
      ..writeln(deactivatedDate);
    return sb.toString();
  }

  // ToRuminate - consider splitting this to avoid passing calibres if no basket
  String getSharableText(Iterable<ArticleCalibre> lines) {
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
        ..writeln('type: ${ticketType.typeString}')
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
        ..writeln('contact : $contactId');
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
        ..writeln('contact : $contactId');
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
        ..writeln('client : $contactId');
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
        ..writeln('fournisseur : $contactId');
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
        ..writeln('client : $contactId');
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
        ..writeln('fournisseur : $contactId');
      return sb.toString();
    } else {
      final sb = StringBuffer()
        ..writeln(shopId)
        ..writeln('ticket # $id')
        ..writeln(
            'date : ${date.year}_${date.month}_${date.day} ${date.hour}:${date.minute}:${date.second}')
        ..writeln('type : $type')
        ..writeln('paiement: ${paiementType.paiementString}')
        ..writeln(products.toString())
        ..writeln('contact : $contactId')
        ..writeln(deactivatedDate);
      return sb.toString();
    }
  }
}
