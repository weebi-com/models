import 'package:collection/collection.dart' show IterableExtension;
import 'package:models_weebi/base.dart';
import 'package:models_weebi/common.dart';
import 'package:models_weebi/weebi_models.dart';

// preparing for null safe yobi
// also a few ready to use extensions for weebi
// TORuminate pursue this using methods in tickets store
// unfinished work

extension FinancialStatsTickets<T extends TicketWeebi> on Iterable<T> {
  int rangeTicketCount(
    DateTime firstDate,
    DateTime lastDate,
  ) {
    return where((t) => t.date.isAfter(firstDate) && t.date.isBefore(lastDate))
        .length;
  }

  int rangeTicketFirst<S extends ShopAbstract>(
      DateTime firstDate, DateTime lastDate) {
    return firstWhereOrNull(
                (t) => t.date.isAfter(firstDate) && t.date.isBefore(lastDate))
            ?.id ??
        0;
  }

  int rangeTicketLast<S extends ShopAbstract>(
          DateTime firstDate, DateTime lastDate) =>
      lastWhereOrNull(
          (t) => t.date.isAfter(firstDate) && t.date.isBefore(lastDate))?.id ??
      0;

  num sumTicketTypePerRange(String ticketType,
      {DateTime? start, DateTime? end}) {
    final filterByRange = (start != null && end != null)
        ? where((t) => t.date.isAfter(start) && t.date.isBefore(end))
            .where((t) => t.status == true)
        : where((t) => t.status == true);
    switch (TicketType.tryParse(ticketType)) {
      case TicketType.sell:
        return filterByRange.where((t) => t.ticketType == TicketType.sell).fold(
            0,
            (num prev, element) =>
                prev + element.totalPriceTaxAndPromoIncluded);

      case TicketType.sellDeferred:
        return filterByRange
            .where((t) => t.ticketType == TicketType.sellDeferred)
            .fold(
                0,
                (num prev, element) =>
                    prev + element.totalCostTaxAndPromoIncluded);

      case TicketType.sellCovered:
        return filterByRange
            .where((t) => t.ticketType == TicketType.sellCovered)
            .fold(0, (prev, element) => prev + element.received);

      case TicketType.spend:
        return filterByRange
            .where((t) => t.ticketType == TicketType.spend)
            .fold(0,
                (prev, element) => prev + element.totalCostTaxAndPromoIncluded);

      case TicketType.spendDeferred:
        return filterByRange
            .where((t) => t.ticketType == TicketType.spendDeferred)
            .fold(0,
                (prev, element) => prev + element.totalCostTaxAndPromoIncluded);

      case TicketType.spendCovered:
        return filterByRange
            .where((t) => t.ticketType == TicketType.spendCovered)
            .fold(0, (prev, element) => prev + element.received);
      case TicketType.wage:
        return filterByRange
            .where((t) => t.ticketType == TicketType.wage)
            .fold(0, (prev, element) => prev + element.received);
      case TicketType.unknown:
        print(
            'rhaaaa unknow ticket type in sumHerderTicketTypeRange, not again !');
        return 0;
      default:
        return 0;
    }
  }

  // Get all tickets concerning wages generation of the month (past month and this month) ...

  List<T> getTicketsInRange(DateTime pastMotnhStart, DateTime thisMonthEnd) =>
      where((t) => t.date.isAfter(pastMotnhStart))
          .where((t) => t.date.isBefore(thisMonthEnd))
          .toList();

  num herderTicketTypeRange(String ticketType, String herderId,
      {DateTime? end}) {
    final filterByRange = (end != null)
        ? where((t) => t.date.isBefore(end))
            .where((t) => t.herderId == herderId)
            .where((t) => t.status)
        : where((t) => t.status).where((t) => t.herderId == herderId);
    switch (TicketType.tryParse(ticketType)) {
      case TicketType.sell:
        return filterByRange.where((t) => t.ticketType == TicketType.sell).fold(
            0, (prev, element) => prev + element.totalPriceTaxAndPromoIncluded);

      case TicketType.sellDeferred:
        return filterByRange
            .where((t) => t.ticketType == TicketType.sellDeferred)
            .fold(0,
                (prev, element) => prev + element.totalCostTaxAndPromoIncluded);

      case TicketType.sellCovered:
        return filterByRange
            .where((t) => t.ticketType == TicketType.sellCovered)
            .fold(0, (prev, element) => prev + element.received);

      case TicketType.spend:
        return filterByRange
            .where((t) => t.ticketType == TicketType.spend)
            .fold(0,
                (prev, element) => prev + element.totalCostTaxAndPromoIncluded);

      case TicketType.spendDeferred:
        return filterByRange
            .where((t) => t.ticketType == TicketType.spendDeferred)
            .fold(0,
                (prev, element) => prev + element.totalCostTaxAndPromoIncluded);

      case TicketType.spendCovered:
        return filterByRange
            .where((t) => t.ticketType == TicketType.spendCovered)
            .fold(0, (prev, element) => prev + element.received);

      case TicketType.wage:
        return filterByRange
            .where((t) => t.ticketType == TicketType.wage)
            .fold(0, (prev, element) => prev + element.received);

      case TicketType.unknown:
        print(
            'rhaaaa unknow ticket type in herderTicketTypeRange, not again !');
        return 0;
      default:
        return 0;
    }
  }

  num supplierSpendCoveredBeforeDate(int herderId, DateTime date) =>
      where((t) => t.herderId == '$herderId')
          .where((t) => t.status == true)
          .where((t) => t.date.isBefore(date))
          .where((t) => t.ticketType == TicketType.spendCovered)
          .fold(0, (prev, e) => prev + e.received);

  num supplierSpendCoveredThisMonth(
          int herderId, DateTime dateMonthStart, DateTime dateMonthEnd) =>
      where((t) => t.status)
          .where((t) => t.herderId == '$herderId')
          .where((t) => t.ticketType == TicketType.spendCovered)
          .where((t) => t.date.isAfter(dateMonthStart))
          .where((t) => t.date.isBefore(dateMonthEnd))
          .fold(0, (prev, e) => prev + e.received);

  num herderAllWages(int herderId, {DateTime? end}) => where((t) => t.status)
      .where((t) => t.herderId == '$herderId')
      .where((t) => t.date.isBefore(end ?? DateTime.now()))
      .where((t) =>
          // * no time, take all the past wage into account
          // until we finally get closing
          t.ticketType == TicketType.wage)
      .fold(0, (prev, e) => prev + e.received);

  // until we have closing

  num herderWageThisMonthOnly(int herderId, DateTime datePreviousMonth) =>
      where((t) => t.status)
          .where((t) => t.herderId == '$herderId')
          .where((t) => t.date.year == datePreviousMonth.year)
          .where((t) => t.date.month == datePreviousMonth.month)
          .where((t) => t.ticketType == TicketType.wage)
          .fold(0, (prev, e) => prev + e.received);

  num supplierSpendDeferredBeforeDate(int herderId, DateTime date) {
    return where((t) => t.herderId == herderId.toString())
        .where((t) => t.status == true)
        .where((t) => t.date.isBefore(date))
        .where((t) => t.ticketType == TicketType.spendDeferred)
        .fold(0, (prev, e) => prev + e.totalCostTaxAndPromoIncluded);
  }

  num supplierSpendDeferredThisMonth(
          int herderId, DateTime dateMonthStart, DateTime dateMonthEnd) =>
      where((t) => t.status)
          .where((t) => t.herderId == '$herderId')
          .where((t) => t.ticketType == TicketType.spendDeferred)
          .where((t) => t.date.isAfter(dateMonthStart))
          .where((t) => t.date.isBefore(dateMonthEnd))
          .fold(0, (prev, e) => prev + e.totalCostTaxAndPromoIncluded);
  // adding ?? to prevent total crash

  //* this could be factorized in a similar fashion to closing to put this file on diet

  num clientSellCoveredBeforeDate(int herderId, DateTime date) =>
      where((t) => t.herderId == herderId.toString())
          .where((t) => t.status == true)
          .where((t) => t.date.isBefore(date))
          .where((t) => t.ticketType == TicketType.sellCovered)
          .fold(0, (prev, e) => prev + e.received);

  num clientSellCoveredRange(int herderId, DateTime start, DateTime end) =>
      where((t) => t.status)
          .where((t) => t.herderId == '$herderId')
          .where((t) => t.date.isAfter(start))
          .where((t) => t.date.isBefore(end))
          .where((t) => t.ticketType == TicketType.sellCovered)
          .fold(0, (prev, e) => prev + e.received);

  //* this could be factorized in a similar fashion to closing to put this file on diet

  num clientSellDeferredBeforeDate(int herderId, DateTime date) {
    return where((t) => t.herderId == herderId.toString())
        .where((t) => t.status)
        .where((t) => t.date.isBefore(date))
        .where((t) => t.ticketType == TicketType.sellDeferred)
        .fold(0, (prev, e) => prev + e.totalCostTaxAndPromoIncluded);
  } // adding this to prevent total crash}

  num clientSellDeferredThisMonth(
      int herderId, DateTime dateMonthStart, DateTime dateMonthEnd) {
    return where((t) => t.status)
        .where((t) => t.herderId == '$herderId')
        .where((t) => t.date.isAfter(dateMonthStart))
        .where((t) => t.date.isBefore(dateMonthEnd))
        .where((t) => t.ticketType == TicketType.sellDeferred)
        .fold(0, (prev, e) => prev + e.totalCostTaxAndPromoIncluded);
  }

  num clientSellThisMonth(
          int herderId, DateTime dateMonthStart, DateTime dateMonthEnd) =>
      where((t) => t.status)
          .where((t) => t.herderId == '$herderId')
          .where((t) => t.date.isAfter(dateMonthStart))
          .where((t) => t.date.isBefore(dateMonthEnd))
          .where((t) => t.ticketType == TicketType.sell)
          .fold(0, (prev, e) => prev + e.totalPriceTaxAndPromoIncluded);

  num supplierSpendThisMonth(
          int herderId, DateTime dateMonthStart, DateTime dateMonthEnd) =>
      where((t) => t.status)
          .where((t) => t.herderId == '$herderId')
          .where((t) => t.date.isAfter(dateMonthStart))
          .where((t) => t.date.isBefore(dateMonthEnd))
          .where((t) => t.ticketType == TicketType.spend)
          .fold(0, (prev, e) => prev + e.totalCostTaxAndPromoIncluded);

  num herderCvoMilkThisMonth(
          int herderId, DateTime dateMonthStart, DateTime dateMonthEnd) =>
      where((t) => t.status)
          .where((t) => t.ticketType == TicketType.spendDeferred)
          .where((t) => t.comment.isNotEmpty)
          .where((t) => t.herderId == '$herderId')
          .where((t) => t.date.isAfter(dateMonthStart))
          .where((t) => t.date.isBefore(dateMonthEnd))
          .fold(0, (prev, val) => prev + val.totalCostPromoVal);

  int herderCvoMilkThisMonthNewWay(
          int herderId, DateTime dateMonthStart, DateTime dateMonthEnd) =>
      (where((t) => t.status)
                  .where((t) => t.ticketType == TicketType.spendDeferred)
                  .where((t) => t.comment.isNotEmpty)
                  .where((t) => t.herderId == '$herderId')
                  .where((t) => t.date.isAfter(dateMonthStart))
                  .where((t) => t.date.isBefore(dateMonthEnd))
                  .fold(
                      0.0,
                      (double prev, t) =>
                          prev +
                          t.items.fold(
                              0.0,
                              (pvv, element) => element.article.id == 1 &&
                                      element.article.productId == 6
                                  ? element.quantity
                                  : 0.0)) *
              5)
          .round();

  int rangeSpendDeferredPromo(DateTime start, DateTime end) =>
      where((t) => t.status == true)
          .where((t) => t.date.isAfter(start))
          .where((t) => t.date.isBefore(end))
          .where((t) => t.paiementType == PaiementType.nope)
          .where((t) => t.ticketType == TicketType.spendDeferred)
          .fold(0, (num prev, element) => prev + (element.totalCostPromoVal))
          .round();

// -----------
// history_herders
// -----------

// * use this and factorize it

  Map<String, H> monthTopClientsSellCashOnly<H extends HerderAbstract>(
      DateTime date, List<H> herdersList) {
    Map<String, H> map = {};
    for (var herder in herdersList) {
      var soldPerClient = where((t) => t.status == true)
          .where((t) => t.date.year == date.year && t.date.month == date.month)
          .where((t) => t.ticketType == TicketType.sell)
          .where((t) => t.paiementType == PaiementType.cash)
          .where((t) => t.herderId == herder.id.toString())
          .fold(
              0,
              (num prev, T element) =>
                  prev + element.totalPriceTaxAndPromoIncluded);

      map[soldPerClient.toString()] = herder;
    }
    return map;
  }

  // * ToRuminate use tickets.allClientsSellAndSellDeferredThisDay

  Map<String, H> allClientsSellAndSellDeferredThisDay<H extends HerderAbstract>(
      DateTime date, List<H> herdersList) {
    Map<String, H> map = {};
    for (var herder in herdersList) {
      var soldPerClient = where((t) => t.status == true)
          .where((t) =>
              t.date.year == date.year &&
              t.date.month == date.month &&
              t.date.day == date.day)
          .where((t) =>
              t.ticketType == TicketType.sell &&
              t.ticketType == TicketType.sellDeferred)
          .where((t) => t.herderId == herder.id.toString())
          .fold(
              0,
              (num prev, element) =>
                  prev + element.totalPriceTaxAndPromoIncluded);

      map[soldPerClient.toString()] = herder;
    }
    return map;
  }
}
