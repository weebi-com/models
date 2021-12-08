// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:http/http.dart' as http; // TODO add the http
import 'package:models_common/utils.dart';
import 'package:models_weebi/src/weebi/item_weebi.dart';
import 'package:models_weebi/src/weebi/taxe_weebi.dart';
import 'package:models_weebi/src/weebi/ticket_mixin_weebi_base.dart';
import 'package:models_weebi/src/weebi/ticket_weebi_abstract.dart';
import 'package:models_weebi/src/weebi/ticket_mixin_weebi_print.dart';
import 'package:models_common/common.dart';

class TicketWeebi extends TicketWeebiAbstract
    with TicketPrinter, TicketMixinWeebiBase {
  TicketWeebi({
    required final String oid,
    required final int id,
    required final String shopId, // shopUuid
    required final List<ItemWeebi> items,
    required final TaxeWeebi taxe,
    required final double promo,
    required final String comment,
    required final int received,
    required final DateTime date,
    required final PaiementType paiementType,
    required final TicketType ticketType,
    required final String contactInfo, // herderId
    required final String contactPastPurchasingPower,
    required final bool status,
    required final DateTime statusUpdateDate,
    required final DateTime creationDate,
  }) : super(
          id: id,
          oid: oid,
          shopId: shopId,
          items: items,
          taxe: taxe,
          promo: promo,
          comment: comment,
          received: received,
          date: date,
          paiementType: paiementType,
          ticketType: ticketType,
          contactInfo: contactInfo,
          contactPastPurchasingPower: contactPastPurchasingPower,
          status: status,
          statusUpdateDate: statusUpdateDate,
          creationDate: creationDate,
        );

  static final dummy = TicketWeebi(
    oid: 'oid',
    id: 1,
    shopId: 'shopId',
    items: [ItemWeebi.dummy],
    taxe: TaxeWeebi.noTax,
    promo: 0.0,
    comment: 'comment',
    received: 0,
    date: WeebiDates.defaultDate,
    paiementType: PaiementType.cash,
    ticketType: TicketType.sell,
    contactInfo: 'contactInfo',
    contactPastPurchasingPower: 'contactPastPurchasingPower',
    status: true,
    statusUpdateDate: WeebiDates.defaultDate,
    creationDate: WeebiDates.defaultDate,
  );

  @override
  int get totalSell => items.fold(0,
      (value, item) => value + ((item.quantity) * item.article.price).round());

  @override
  int get totalSellPromo =>
      promo != null ? (totalSell * promo / 100).round() : 0;

  @override
  int get totalSellHtIncludingPromo => totalSell - totalSellPromo;

  @override
  int get totalSellTaxes => ((taxe.percentage) > 0.0
          ? totalSellHtIncludingPromo * (taxe.percentage) / 100
          : 0)
      .round();

  @override
  int get totalSellTtc => totalSellHtIncludingPromo + totalSellTaxes;

  @override
  int get totalSpend => items.fold(
      0,
      (value, item) =>
          value + ((item?.quantity ?? 0.0) * (item.article.cost ?? 0)).round());

  @override
  int get totalSpendPromo {
    print('promo $promo');
    return promo != null ? (totalSpend * promo / 100).round() : 0;
  }

  @override
  int get totalSpendHtIncludingPromo => totalSpend - totalSpendPromo;

  @override
  int get totalSpendTaxes => (((taxe.percentage ?? 0.0)) > 0
          ? totalSpendHtIncludingPromo * ((taxe.percentage ?? 0.0)) / 100
          : 0)
      .round();

  @override
  int get totalSpendTtc => totalSpendHtIncludingPromo + totalSpendTaxes;

  @override
  int get totalSpendDeferredHt {
    double owed = 0;
    for (final item in items) {
      // if (item.lots != null && item.lots!.isNotEmpty && item.lots!.length > 1) {
      //   owed += ((item.article.cost ?? 0) * item.lots.length)?.toDouble();
      // } else
      owed += (item.article.cost ?? 0) * (item?.quantity ?? 0);
    }
    return owed.round() ?? 0;
  }

  @override
  int get totalSpendDeferredPromo =>
      promo != null ? (totalSpendDeferredHt * (promo / 100)).round() : 0;

  @override
  int get totalSpendDeferredHtIncludingPromo =>
      totalSpendDeferredHt - totalSpendDeferredPromo;

  @override
  int get totalSpendDeferredTaxes => (taxe.percentage ?? 0.0) > 0.0
      ? (totalSpendDeferredHtIncludingPromo * ((taxe.percentage ?? 0.0) / 100))
          .round()
      : 0;

  @override
  int get totalSpendDeferredTtc =>
      totalSpendDeferredHtIncludingPromo + totalSpendDeferredTaxes;

  @override
  int get totalSellDeferredHt {
    double owed = 0;
    for (final item in items) {
      // if (item.lots.length > 1) {
      //   owed += ((item.article.price ?? 0) * item.lots.length)?.toDouble();
      // } else
      //
      owed += (item.article.price ?? 0) * (item?.quantity ?? 0);
    }
    return owed.round() ?? 0;
  }

  @override
  int get totalSellDeferredPromo =>
      promo != null ? (totalSellDeferredHt * (promo) / 100).round() : 0;

  @override
  int get totalSellDeferredHtIncludingPromo =>
      totalSellDeferredHt - totalSellDeferredPromo;

  @override
  int get totalSellDeferredTaxes => (taxe.percentage ?? 0.0) > 0.0
      ? (totalSellDeferredHtIncludingPromo * ((taxe.percentage ?? 0.0)) / 100)
          .round()
      : 0;

  @override
  int get totalSellDeferredTtc =>
      totalSellDeferredHtIncludingPromo + totalSellDeferredTaxes;

  @override
  int get total {
    switch (ticketType) {
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
  }

  @override
  String get deactivatedDate {
    if (status == true) {
      return '';
    } else {
      return '$statusUpdateDate';
    }
  }

  @override
  String get paiement {
    if (paiementType == PaiementType.nope) {
      return 'a credit';
    } else if (paiementType == PaiementType.yup) {
      return 'yup';
    } else if (paiementType == PaiementType.goods) {
      return 'autres';
    } else if (paiementType == PaiementType.cheque) {
      return 'cheque';
    } else if (paiementType == PaiementType.cb) {
      return 'carte';
    }
    return 'cash';
  }

  @override
  String get type {
    if (ticketType == TicketType.stockIn) {
      return 'Entrée stock';
    } else if (ticketType == TicketType.stockOut) {
      return 'Sortie de stock';
    } else if (ticketType == TicketType.sell) {
      return 'Vente';
    } else if (ticketType == TicketType.sellCovered) {
      return 'Versement client';
    } else if (ticketType == TicketType.sellDeferred) {
      return 'Vente a credit';
    } else if (ticketType == TicketType.spend) {
      return 'Achat';
    } else if (ticketType == TicketType.spendCovered) {
      return 'Versement fournisseur';
    } else if (ticketType == TicketType.spendDeferred) {
      return 'Achat a credit';
    } else if (ticketType == TicketType.wage) {
      return 'Salaire';
    }
    return 'Autres';
  }

  @override
  set statusUpdateDate(DateTime? _statusUpdateDate) {
    statusUpdateDate = _statusUpdateDate;
  }

  factory TicketWeebi.fromJson(String source) =>
      TicketWeebi.fromMap(json.decode(source));

  factory TicketWeebi.fromMap(Map<String, dynamic> map) {
    return TicketWeebi(
      id: map['id'],
      oid: map['oid'],
      shopId: map['shopId'],
      items:
          List<ItemWeebi>.from(map['items']?.map((x) => ItemWeebi.fromMap(x))),
      taxe: TaxeWeebi.fromMap(map['taxe']),
      promo: map['promo'],
      comment: map['comment'],
      contactPastPurchasingPower: map['contactPastPurchasingPower'],
      received: map['received'],
      date: DateTime.tryParse(map['date']) ?? WeebiDates.defaultDate,
      paiementType: PaiementType.tryParse(map['paiementType']),
      ticketType: TicketType.tryParse(map['ticketType']),
      contactInfo: map['contactInfo'],
      status: map['status'],
      statusUpdateDate:
          DateTime.tryParse(map['statusUpdateDate']) ?? WeebiDates.defaultDate,
      creationDate:
          DateTime.tryParse(map['creationDate']) ?? WeebiDates.defaultDate,
      // isInDash: map['isInDash'],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shopUuid': shopUuid,
      'items': items.map((x) => x.toMap()).toList(),
      'taxe': taxe.toMap(),
      'promo': promo,
      'comment': comment,
      'contactPastPurchasingPower': contactPastPurchasingPower,
      'received': received,
      'date': date.toIso8601String(),
      'paiementType': paiementType.toString(),
      'ticketType': ticketType.toString(),
      'herderId': herderId,
      'status': status,
      'statusUpdateDate': statusUpdateDate.toIso8601String(),
      'creationDate': creationDate.toIso8601String(),
      'isInDash': isInDash,
    };
  }
}
