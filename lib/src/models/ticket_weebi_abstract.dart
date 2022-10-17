import 'package:models_weebi/base.dart' hide ItemAbstract;
import 'package:models_base/common.dart';
import 'package:models_weebi/weebi_models.dart';

// Using WeebiAbstract to rename the attributes shopId && contactInfo,
// That were stupidly changed by a young idealistic dev

abstract class TicketWeebiAbstract
    implements TicketAbstract<ItemCartWeebi, TaxeWeebi> {
  final String oid; // mongo _id
  final String shopId; // shopUuid
  final String contactInfo; // herderId
  @override
  final int id;
  @override
  String get shopUuid => shopId; // shopUuid // shopId
  @override
  final List<ItemCartWeebi> items;
  @override
  final TaxeWeebi taxe;
  @override
  final double promo;
  @override
  final String comment;
  @override
  final int received;
  @override
  final DateTime date;
  @override
  final PaiementType paiementType;
  @override
  final TicketType ticketType;
  @override
  String get herderId => contactInfo;
  @override
  final String contactPastPurchasingPower;
  @override
  late bool status;
  @override
  final DateTime statusUpdateDate;
  @override
  final DateTime creationDate;
  @override
  late bool isInDash;

  TicketWeebiAbstract({
    required this.id,
    required this.oid,
    required this.shopId,
    required this.items,
    required this.taxe,
    required this.promo,
    required this.comment,
    required this.received,
    required this.date,
    required this.paiementType,
    required this.ticketType,
    required this.contactInfo,
    required this.contactPastPurchasingPower,
    required this.status,
    required this.statusUpdateDate,
    required this.creationDate,
    this.isInDash = true,
  });

  int get totalSellTaxAndPromoExcluded => items.totalPriceTaxAndPromoExcluded;

  int get totalSellPromo =>
      (totalSellTaxAndPromoExcluded * promo / 100).round();

  int get totalSellTaxExcludedIncludingPromo =>
      totalSellTaxAndPromoExcluded - totalSellPromo;

  int get totalSellTaxes => ((taxe.percentage) > 0.0
          ? totalSellTaxExcludedIncludingPromo * (taxe.percentage) / 100
          : 0)
      .round();

  int get totalSellTaxAndPromoIncluded =>
      totalSellTaxExcludedIncludingPromo + totalSellTaxes;

  int get totalSpendTaxAndPromoExcluded => items.totalCostTaxAndPromoExcluded;

  int get totalSpendPromo =>
      (totalSpendTaxAndPromoExcluded * promo / 100).round();

  int get totalSpendTaxExcludedIncludingPromo =>
      totalSpendTaxAndPromoExcluded - totalSpendPromo;

  int get totalSpendTaxes => (taxe.percentage > 0
          ? totalSpendTaxExcludedIncludingPromo * (taxe.percentage) / 100
          : 0)
      .round();

  int get totalSpendTaxAndPromoIncluded =>
      totalSpendTaxExcludedIncludingPromo + totalSpendTaxes;

  int get totalSpendDeferredTaxAndPromoExcluded =>
      items.totalCostTaxAndPromoExcluded;

  int get totalSpendDeferredPromo =>
      (totalSpendDeferredTaxAndPromoExcluded * (promo / 100)).round();

  int get totalSpendDeferredTaxExcludedIncludingPromo =>
      totalSpendDeferredTaxAndPromoExcluded - totalSpendDeferredPromo;

  int get totalSpendDeferredTaxes => taxe.percentage > 0.0
      ? (totalSpendDeferredTaxExcludedIncludingPromo * taxe.percentage / 100)
          .round()
      : 0;

  int get totalSpendDeferredTaxAndPromoIncluded =>
      totalSpendDeferredTaxExcludedIncludingPromo + totalSpendDeferredTaxes;

  int get totalSellDeferredTaxAndPromoExcluded =>
      items.totalPriceTaxAndPromoExcluded;

  int get totalSellDeferredPromo =>
      (totalSellDeferredTaxAndPromoExcluded * (promo) / 100).round();

  int get totalSellDeferredTaxExcludedPromoIncluded =>
      totalSellDeferredTaxAndPromoExcluded - totalSellDeferredPromo;

  int get totalSellDeferredTaxes => taxe.percentage > 0.0
      ? (totalSellDeferredTaxExcludedPromoIncluded * (taxe.percentage) / 100)
          .round()
      : 0;

  int get totalSellDeferredTaxAndPromoIncluded =>
      totalSellDeferredTaxExcludedPromoIncluded + totalSellDeferredTaxes;

  int get total {
    switch (ticketType) {
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
  }

  String get deactivatedDate => status ? '' : '$statusUpdateDate';

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
}
