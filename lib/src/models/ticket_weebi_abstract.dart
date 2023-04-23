import 'package:models_weebi/base.dart' hide ItemAbstract;
import 'package:models_base/common.dart';
import 'package:models_weebi/weebi_models.dart';

// Using WeebiAbstract to rename the attributes shopId && contactInfo,
// That were stupidly changed by a young idealistic dev

extension PriceCostGetter on TicketType {
  bool get isPrice =>
      this == TicketType.sell || this == TicketType.sellDeferred;
  bool get isCost =>
      this == TicketType.spend || this == TicketType.spendDeferred;
}

mixin TotalComputer {
  int promoVal(int itemsTotal, double promo) =>
      (itemsTotal * promo / 100).round();

  int totalTaxExcludedPromoIncluded(
          int itemsTotal, double promo, int discountAmount) =>
      itemsTotal - promoVal(itemsTotal, promo) - discountAmount;

  int taxesVal(
    int itemsTotal,
    double promo,
    int discountAmount,
    double taxePercentage,
  ) =>
      (taxePercentage > 0.0
              ? totalTaxExcludedPromoIncluded(
                      itemsTotal, promo, discountAmount) *
                  (taxePercentage / 100)
              : 0)
          .round();

  int totalTaxAndPromoIncluded(
    int itemsTotal,
    double promo,
    int discountAmount,
    double taxePercentage,
  ) =>
      totalTaxExcludedPromoIncluded(itemsTotal, promo, discountAmount) +
      taxesVal(itemsTotal, promo, discountAmount, taxePercentage);
}

abstract class TicketWeebiAbstract
    with TotalComputer
    implements TicketAbstract<ItemCartWeebi, TaxWeebi> {
  final String oid; // mongo _id
  final String shopId; // shopUuid
  final String contactInfo; // herderId
  final int discountAmount;
  @override
  final int id;
  @override
  String get shopUuid => shopId; // shopUuid // shopId
  @override
  final List<ItemCartWeebi> items;
  @override
  final TaxWeebi taxe;
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
    this.discountAmount = 0,
  });

  // sell and sellDeferred
  int get totalPriceItemsOnly => ticketType.isPrice ? items.itemsTotalPrice : 0;

  int get totalPricePromoVal => promoVal(totalPriceItemsOnly, promo);

  int get totalPriceTaxExcludedPromoIncluded =>
      totalTaxExcludedPromoIncluded(totalPriceItemsOnly, promo, discountAmount);

  int get totalPriceTaxesVal =>
      taxesVal(totalPriceItemsOnly, promo, discountAmount, taxe.percentage);

  int get totalPriceTaxAndPromoIncluded => totalTaxAndPromoIncluded(
        totalPriceItemsOnly,
        promo,
        discountAmount,
        taxe.percentage,
      );
// spend and spendDeferred below
  int get totalCostItemsOnly => ticketType.isCost ? items.itemsTotalCost : 0;

  int get totalCostPromoVal => promoVal(totalCostItemsOnly, promo);

  int get totalCostTaxExcludedIncludingPromo =>
      totalTaxExcludedPromoIncluded(totalCostItemsOnly, promo, discountAmount);

  int get totalCostTaxesVal =>
      taxesVal(totalCostItemsOnly, promo, discountAmount, taxe.percentage);

  int get totalCostTaxAndPromoIncluded => totalTaxAndPromoIncluded(
      totalCostItemsOnly, promo, discountAmount, taxe.percentage);

  int get total {
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
  }

  String get deactivatedDate => status ? '' : '$statusUpdateDate';

  String get paiement {
    if (paiementType == PaiementType.nope) {
      return 'a credit';
    } else if (paiementType == PaiementType.mobileMoney) {
      return 'm.money';
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
