// import 'package:mobx/mobx.dart';
// import 'package:models_base/src/base/ticket_base.dart';
// import 'package:models_base/extensions/date_time.dart';
// import 'package:models_base/src/base/article_base.dart';
// import 'package:models_base/src/base/herder_base.dart';
// import 'package:models_base/src/base/lot_base.dart';
// import 'package:models_base/src/base/shop_base.dart';
// import 'package:models_base/src/base/product_base.dart';
// import 'package:models_base/src/common/paiement_type.dart';
// import 'package:models_base/src/common/ticket_type.dart';
// import 'package:models_base/utils.dart';

// lunch() {
//   final ObservableList<Ticket> tt = ObservableList.of([]);
//   tt.rangeTicketCount<ShopDummy>(
//       WeebiDates.defaultDate, WeebiDates.defaultDate, []);
// }

// TODO refactor some of these into switch 
// TODO move to null safety
// TODO include the <S extends ShopAbstract> generics where required (like above)

// extension StatsTickets on ObservableList<Ticket> {
//   int rangeTicketCount<S extends ShopAbstract>(
//     DateTime firstDate,
//     DateTime lastDate,
//     List<S> dashboardShops, // ? this uuid
//   ) {
//     int rangeTicketCount = 0;
//     // si y a plus d'un shop dans le dashboard c'est que l'on affiche le total
//     if (dashboardShops.isNotEmpty) {
//       for (final shop in dashboardShops) {
//         final filterTicketsByShop = where((t) => t.shopUuid == shop.uuid);
//         if (filterTicketsByShop.isNotEmpty) {
//           rangeTicketCount += filterTicketsByShop
//               .where(
//                   (t) => t.date.isAfter(firstDate) && t.date.isBefore(lastDate))
//               .length;
//         }
//       }
//     }
//     return rangeTicketCount;
//   }

//   int rangeTicketFirst(
//       DateTime firstDate, DateTime lastDate, List<Shop> dashboardShops) {
//     int rangeTicketFirst;
//     if (dashboardShops.isNotEmpty) {
//       for (final shop in dashboardShops) {
//         var filterTicketsByShop = where((t) => t.shopUuid == shop.uuid);
//         if (filterTicketsByShop != null && filterTicketsByShop.isNotEmpty) {
//           rangeTicketFirst = filterTicketsByShop
//               //.where((t) => t.shopUuid == dashboardShops.where((s) => s.uuid == t.shopUuid))
//               .firstWhere(
//                   (t) => t.date.isAfter(firstDate) && t.date.isBefore(lastDate),
//                   orElse: () => null)
//               ?.id;
//         }
//       }
//     }
//     return rangeTicketFirst;
//   }

//   int rangeTicketLast(
//       DateTime firstDate, DateTime lastDate, List<Shop> dashboardShops) {
//     int rangeTicketLast;
//     if (dashboardShops.isNotEmpty) {
//       for (final shop in dashboardShops) {
//         var filterTicketsByShop = where((t) => t.shopUuid == shop.uuid);
//         if (filterTicketsByShop != null && filterTicketsByShop.isNotEmpty) {
//           rangeTicketLast = filterTicketsByShop
//               ?.lastWhere(
//                   (t) => t.date.isAfter(firstDate) && t.date.isBefore(lastDate),
//                   orElse: () => first)
//               ?.id;
//         }
//       }
//     }
//     return rangeTicketLast;
//   }

//   int rangeMarginRaw(
//           DateTime firstDate, DateTime lastDate, List<Shop> dashboardShops) =>
//       sumTicketTypePerRangeAndShops(
//         dashboardShops,
//         '${TicketType.sell}',
//         start: firstDate,
//         end: lastDate,
//       ) +
//       sumTicketTypePerRangeAndShops(
//         dashboardShops,
//         '${TicketType.spend}',
//         start: firstDate,
//         end: lastDate,
//       ) -
//       sumTicketTypePerRangeAndShops(
//         dashboardShops,
//         '${TicketType.wage}',
//         start: firstDate,
//         end: lastDate,
//       );

//   int sumTicketTypePerRangeAndShops(
//       List<Shop> dashboardShops, String ticketType,
//       {DateTime start, DateTime? end}) {
//     var tt = 0;
//     final filterByRange = (start != null && end != null)
//         ? where((t) => t.date.isAfter(start) && t.date.isBefore(end))
//             .where((t) => t.status == true)
//         : where((t) => t.status == true);
//     dashboardShops.forEach((shop) {
//       switch (TicketType.tryParse(ticketType)) {
//         case TicketType.sell:
//           tt += filterByRange
//               .where((t) => t.shopUuid == shop.uuid)
//               .where((t) => t.ticketType == TicketType.sell)
//               .fold(0, (prev, element) => prev + element.totalSellTtc);
//           break;
//         case TicketType.sellDeferred:
//           tt += filterByRange
//               .where((t) => t.shopUuid == shop.uuid)
//               .where((t) => t.ticketType == TicketType.sellDeferred)
//               .fold(0, (prev, element) => prev + element.totalSellDeferredTtc);
//           break;
//         case TicketType.sellCovered:
//           tt += filterByRange
//               .where((t) => t.shopUuid == shop.uuid)
//               .where((t) => t.ticketType == TicketType.sellCovered)
//               .fold(0, (prev, element) => prev + element.received);
//           break;
//         case TicketType.spend:
//           tt += filterByRange
//               .where((t) => t.shopUuid == shop.uuid)
//               .where((t) => t.ticketType == TicketType.spend)
//               .fold(0, (prev, element) => prev + element.totalSpendTtc);
//           break;
//         case TicketType.spendDeferred:
//           tt += filterByRange
//               .where((t) => t.shopUuid == shop.uuid)
//               .where((t) => t.ticketType == TicketType.spendDeferred)
//               .fold(0, (prev, element) => prev + element.totalSpendDeferredTtc);
//           break;
//         case TicketType.spendCovered:
//           tt += filterByRange
//               .where((t) => t.shopUuid == shop.uuid)
//               .where((t) => t.ticketType == TicketType.spendCovered)
//               .fold(0, (prev, element) => prev + element.received);
//           break;
//         case TicketType.wage:
//           tt += filterByRange
//               .where((t) => t.shopUuid == shop.uuid)
//               .where((t) => t.ticketType == TicketType.wage)
//               .fold(0, (prev, element) => prev + element.received);
//           break;
//         case TicketType.unknown:
//           print(
//               'rhaaaa unknow ticket type in sumHerderTicketTypeRange, not again !');
//           break;
//           return null;
//         default:
//           return null;
//       }
//     });
//     return tt;
//   }

//   int sumTicketTypePerRange(String ticketType,
//       {DateTime start, DateTime? end}) {
//     final filterByRange = (start != null && end != null)
//         ? where((t) => t.date.isAfter(start) && t.date.isBefore(end))
//             .where((t) => t.status == true)
//         : where((t) => t.status == true);
//     switch (TicketType.tryParse(ticketType)) {
//       case TicketType.sell:
//         return filterByRange
//             .where((t) => t.ticketType == TicketType.sell)
//             .fold(0, (prev, element) => prev + element.totalSellTtc);
//       case TicketType.sellDeferred:
//         return filterByRange
//             .where((t) => t.ticketType == TicketType.sellDeferred)
//             .fold(0, (prev, element) => prev + element.totalSellDeferredTtc);
//       case TicketType.sellCovered:
//         return filterByRange
//             .where((t) => t.ticketType == TicketType.sellCovered)
//             .fold(0, (prev, element) => prev + element.received);
//       case TicketType.spend:
//         return filterByRange
//             .where((t) => t.ticketType == TicketType.spend)
//             .fold(0, (prev, element) => prev + element.totalSpendTtc);
//       case TicketType.spendDeferred:
//         return filterByRange
//             .where((t) => t.ticketType == TicketType.spendDeferred)
//             .fold(0, (prev, element) => prev + element.totalSpendDeferredTtc);
//       case TicketType.spendCovered:
//         return filterByRange
//             .where((t) => t.ticketType == TicketType.spendCovered)
//             .fold(0, (prev, element) => prev + element.received);
//       case TicketType.wage:
//         return filterByRange
//             .where((t) => t.ticketType == TicketType.wage)
//             .fold(0, (prev, element) => prev + element.received);
//       case TicketType.unknown:
//         print(
//             'rhaaaa unknow ticket type in sumHerderTicketTypeRange, not again !');
//         return 0;
//       default:
//         return 0;
//     }
//   }

//   // Get all tickets concerning wages generation of the month (past month and this month) ...

//   List<Ticket> getTicketsInRange(
//           DateTime pastMotnhStart, DateTime thisMonthEnd) =>
//       where((t) => t.date.isAfter(pastMotnhStart))
//           .where((t) => t.date.isBefore(thisMonthEnd))
//           .toList();

//   int herderTicketTypeRange(String ticketType, String herderId,
//       {DateTime? end}) {
//     final filterByRange = (end != null)
//         ? where((t) => t.date.isBefore(end))
//             .where((t) => t.herderId == herderId)
//             .where((t) => t.status)
//         : where((t) => t.status).where((t) => t.herderId == herderId);
//     switch (TicketType.tryParse(ticketType)) {
//       case TicketType.sell:
//         return filterByRange
//             .where((t) => t.ticketType == TicketType.sell)
//             .fold(0, (prev, element) => prev + element.totalSellTtc);

//       case TicketType.sellDeferred:
//         return filterByRange
//             .where((t) => t.ticketType == TicketType.sellDeferred)
//             .fold(0, (prev, element) => prev + element.totalSellDeferredTtc);

//       case TicketType.sellCovered:
//         return filterByRange
//             .where((t) => t.ticketType == TicketType.sellCovered)
//             .fold(0, (prev, element) => prev + element.received);

//       case TicketType.spend:
//         return filterByRange
//             .where((t) => t.ticketType == TicketType.spend)
//             .fold(0, (prev, element) => prev + element.totalSpendTtc);

//       case TicketType.spendDeferred:
//         return filterByRange
//             .where((t) => t.ticketType == TicketType.spendDeferred)
//             .fold(0, (prev, element) => prev + element.totalSpendDeferredTtc);

//       case TicketType.spendCovered:
//         return filterByRange
//             .where((t) => t.ticketType == TicketType.spendCovered)
//             .fold(0, (prev, element) => prev + element.received);

//       case TicketType.wage:
//         return filterByRange
//             .where((t) => t.ticketType == TicketType.wage)
//             .fold(0, (prev, element) => prev + element.received);

//       case TicketType.unknown:
//         print(
//             'rhaaaa unknow ticket type in herderTicketTypeRange, not again !');
//         return 0;
//       default:
//         return 0;
//     }
//   }

//   int supplierSpendCoveredBeforeDate(int herderId, DateTime date) =>
//       where((t) => t?.herderId == '$herderId')
//           .where((t) => t?.status == true)
//           .where((t) => t.date.isBefore(date))
//           .where((t) => t?.ticketType == TicketType?.spendCovered)
//           .fold(0, (prev, e) => prev + e.received);

//   int supplierSpendCoveredThisMonth(
//           int herderId, DateTime dateMonthStart, DateTime dateMonthEnd) =>
//       where((t) => t.status)
//           .where((t) => t?.herderId == '$herderId')
//           .where((t) => t?.ticketType == TicketType?.spendCovered)
//           .where((t) => t.date.isAfter(dateMonthStart))
//           .where((t) => t.date.isBefore(dateMonthEnd))
//           .fold(0, (prev, e) => prev + e.received);

//   int herderAllWages(int herderId, {DateTime? end}) => where((t) => t.status)
//       .where((t) => t?.herderId == '$herderId')
//       .where((t) => t.date.isBefore(end ?? DateTime.now()))
//       .where((t) =>
//           // * no time, take all the past wage into account
//           // until we finally get closing
//           t?.ticketType == TicketType?.wage)
//       .fold(0, (prev, e) => prev + e.received);

//   // until we have closing

//   int herderWageThisMonthOnly(int herderId, DateTime datePreviousMonth) =>
//       where((t) => t.status)
//           .where((t) => t?.herderId == '$herderId')
//           .where((t) => t.date.year == datePreviousMonth.year)
//           .where((t) => t.date.month == datePreviousMonth.month)
//           .where((t) => t?.ticketType == TicketType?.wage)
//           .fold(0, (prev, e) => prev + e.received);

//   int supplierSpendDeferredBeforeDate(int herderId, DateTime date) =>
//       where((t) => t.herderId == herderId.toString())
//           .where((t) => t.status == true)
//           .where((t) => t.date.isBefore(date))
//           .where((t) => t.ticketType == TicketType.spendDeferred)
//           .fold(0, (prev, e) => prev + e.totalSpendDeferredTtc ?? 0);

//   int supplierSpendDeferredThisMonth(
//           int herderId, DateTime dateMonthStart, DateTime dateMonthEnd) =>
//       where((t) => t.status)
//           .where((t) => t?.herderId == '$herderId')
//           .where((t) => t?.ticketType == TicketType?.spendDeferred)
//           .where((t) => t.date.isAfter(dateMonthStart))
//           .where((t) => t.date.isBefore(dateMonthEnd))
//           .fold(0, (prev, e) => prev + e.totalSpendDeferredTtc ?? 0);
//   // adding ?? to prevent total crash

//   //* this could be factorized in a similar fashion to closing to put this file on diet

//   int clientSellCoveredBeforeDate(int herderId, DateTime date) =>
//       where((t) => t?.herderId == herderId.toString())
//           .where((t) => t?.status == true)
//           .where((t) => t.date.isBefore(date))
//           .where((t) => t?.ticketType == TicketType?.sellCovered)
//           .fold(0, (prev, e) => prev + e.received ?? 0);

//   int clientSellCoveredRange(int herderId, DateTime start, DateTime end) =>
//       where((t) => t.status)
//           .where((t) => t?.herderId == '$herderId')
//           .where((t) => t.date.isAfter(start))
//           .where((t) => t.date.isBefore(end))
//           .where((t) => t?.ticketType == TicketType?.sellCovered)
//           .fold(0, (prev, e) => prev + e.received ?? 0);

//   //* this could be factorized in a similar fashion to closing to put this file on diet

//   int clientSellDeferredBeforeDate(int herderId, DateTime date) {
//     return where((t) => t.herderId == herderId.toString())
//         .where((t) => t.status)
//         .where((t) => t.date.isBefore(date))
//         .where((t) => t?.ticketType == TicketType?.sellDeferred)
//         .fold(0, (prev, e) => prev + e.totalSellDeferredTtc ?? 0);
//   } // adding this to prevent total crash}

//   int clientSellDeferredThisMonth(
//       int herderId, DateTime dateMonthStart, DateTime dateMonthEnd) {
//     return where((t) => t.status)
//         .where((t) => t?.herderId == '$herderId')
//         .where((t) => t.date.isAfter(dateMonthStart))
//         .where((t) => t.date.isBefore(dateMonthEnd))
//         .where((t) => t?.ticketType == TicketType?.sellDeferred)
//         .fold(0, (prev, e) => prev + e.totalSellDeferredTtc ?? 0);
//   }

//   int clientSellThisMonth(
//           int herderId, DateTime dateMonthStart, DateTime dateMonthEnd) =>
//       where((t) => t.status)
//           .where((t) => t?.herderId == '$herderId')
//           .where((t) => t.date.isAfter(dateMonthStart))
//           .where((t) => t.date.isBefore(dateMonthEnd))
//           .where((t) => t?.ticketType == TicketType?.sell)
//           .fold(0, (prev, e) => prev + e.totalSellTtc ?? 0);

//   int supplierSpendThisMonth(
//           int herderId, DateTime dateMonthStart, DateTime dateMonthEnd) =>
//       where((t) => t.status)
//           .where((t) => t?.herderId == '$herderId')
//           .where((t) => t.date.isAfter(dateMonthStart))
//           .where((t) => t.date.isBefore(dateMonthEnd))
//           .where((t) => t?.ticketType == TicketType?.spend)
//           .fold(0, (prev, e) => prev + e.totalSpendTtc ?? 0);

//   int herderCvoMilkThisMonth(
//           int herderId, DateTime dateMonthStart, DateTime dateMonthEnd) =>
//       where((t) => t.status)
//           .where((t) => t.ticketType == TicketType.spendDeferred)
//           .where((t) => t.comment.isNotEmpty)
//           .where((t) => t.herderId == '$herderId')
//           .where((t) => t.date.isAfter(dateMonthStart))
//           .where((t) => t.date.isBefore(dateMonthEnd))
//           .fold(0, (prev, val) => prev + val.totalSpendPromo);

//   int rangeSpendDeferredPromo(DateTime start, DateTime end) =>
//       where((t) => t.status == true)
//           .where((t) => t.date.isAfter(start))
//           .where((t) => t.date.isBefore(end))
//           .where((t) => t.paiementType == PaiementType.nope)
//           .where((t) => t.ticketType == TicketType.spendDeferred)
//           .fold(
//               0,
//               (int? prev, element) =>
//                   (prev ?? 0) + (element?.totalSpendDeferredPromo ?? 0))
//           .round();

//   int rangeSellPromo(
//       DateTime firstDate, DateTime lastDate, List<Shop> dashboardShops) {
//     int rangeSellPromo = 0;
//     int rangeSellDeferredPromo = 0;
//     if (dashboardShops.isNotEmpty) {
//       for (final shop in dashboardShops) {
//         var filterTicketsByShop = where((t) => t.shopUuid == shop.uuid);
//         if (filterTicketsByShop != null && filterTicketsByShop.isNotEmpty) {
//           rangeSellPromo += filterTicketsByShop
//               .where((t) => t.status == true)
//               .where(
//                   (t) => t.date.isAfter(firstDate) && t.date.isBefore(lastDate))
//               .where((t) => t.paiementType == PaiementType.nope)
//               .where((t) => t.ticketType == TicketType.sell)
//               .fold(0, (prev, element) => prev + element.totalSellPromo);
//           rangeSellDeferredPromo += filterTicketsByShop
//               .where((t) => t.status == true)
//               .where(
//                   (t) => t.date.isAfter(firstDate) && t.date.isBefore(lastDate))
//               .where((t) => t.paiementType == PaiementType.nope)
//               .where((t) => t.ticketType == TicketType.sellDeferred)
//               .fold(
//                   0,
//                   (prev, element) =>
//                       prev + (element?.totalSellDeferredPromo ?? 0));
//         }
//         rangeSellPromo += rangeSellDeferredPromo;
//       }
//     }
//     return rangeSellPromo.round();
//   }

// // -----------
// // history_herders
// // -----------

// // * use this and factorize it

//   Map<String, Herder> monthTopClientsSellCashOnly(
//       DateTime date, List<Herder> herdersList) {
//     Map<String, Herder> map = new Map();
//     for (var herder in herdersList) {
//       var soldPerClient = where((t) => t.status == true)
//           .where((t) => t.date.year == date.year && t.date.month == date.month)
//           .where((t) => t.ticketType == TicketType.sell)
//           .where((t) => t.paiementType == PaiementType.cash)
//           .where((t) => t.herderId == herder.id.toString())
//           .fold(0, (prev, element) => prev + element?.totalSellTtc ?? 0);

//       map[soldPerClient.toString()] = herder;
//     }
//     return map;
//   }

//   // TODO use tickets.allClientsSellAndSellDeferredThisDay

//   Map<String, Herder> allClientsSellAndSellDeferredThisDay(
//       DateTime date, List<Herder> herdersList) {
//     Map<String, Herder> map = new Map();
//     for (var herder in herdersList) {
//       var soldPerClient = where((t) => t.status == true)
//           .where((t) =>
//               t.date.year == date.year &&
//               t.date.month == date.month &&
//               t.date.day == date.day)
//           .where((t) =>
//               t.ticketType == TicketType.sell &&
//               t.ticketType == TicketType.sellDeferred)
//           .where((t) => t.herderId == herder.id.toString())
//           .fold(0, (prev, element) => prev + element?.totalSellTtc ?? 0);

//       map[soldPerClient.toString()] = herder;
//     }
//     return map;
//   }

//   double herderMilkVolumeThisDay(DateTime date, Herder herder) {
//     var milkToday = 0.0;
//     if (isEmpty) {
//       return milkToday;
//     }
//     var spendTicketsPerHerder = where((t) => t.status == true)
//         .where((t) =>
//             t.date.year == date.year &&
//             t.date.month == date.month &&
//             t.date.day == date.day)
//         .where((t) => t.ticketType == TicketType.spendDeferred)
//         .where((t) => t.paiementType == PaiementType.nope)
//         .where((t) => t.herderId == herder.id.toString());
//     for (final ticket in spendTicketsPerHerder) {
//       for (final item in ticket.items) {
//         if (item.lots.length > 1) {
//           item.lots.forEach((element) => milkToday += 1);
//         } else {
//           milkToday += item?.quantity;
//         }
//       }
//     }
//     return milkToday;
//   }

//   double herderMilkVolumeThisMorning(DateTime date, Herder herder) {
//     var milkToday = 0.0;
//     if (isEmpty) {
//       return milkToday;
//     }
//     var spendTicketsPerHerder = where((t) => t.status == true)
//         .where((t) =>
//             t.date.year == date.year &&
//             t.date.month == date.month &&
//             t.date.day == date.day &&
//             t.date.isAfter(DateTime(date.year, date.month, date.day, 0, 1)) &&
//             t.date.isBefore(DateTime(date.year, date.month, date.day, 13, 30)))
//         .where((t) => t.ticketType == TicketType.spendDeferred)
//         .where((t) => t.paiementType == PaiementType.nope)
//         .where((t) => t.herderId == herder.id.toString());
//     for (final ticket in spendTicketsPerHerder) {
//       for (final item in ticket.items) {
//         if (item.lots.length > 1) {
//           item.lots.forEach((element) => milkToday += 1);
//         } else {
//           milkToday += item?.quantity;
//         }
//       }
//     }
//     return milkToday;
//   }

//   double herderMilkVolumeThisAfternoon(DateTime date, Herder herder) {
//     var milkToday = 0.0;
//     if (isEmpty) {
//       return milkToday;
//     }
//     var spendTicketsPerHerder = where((t) => t.status == true)
//         .where((t) =>
//             t.date.year == date.year &&
//             t.date.month == date.month &&
//             t.date.day == date.day &&
//             t.date.isAfter(DateTime(date.year, date.month, date.day, 13, 31)))
//         .where((t) => t.ticketType == TicketType.spendDeferred)
//         .where((t) => t.paiementType == PaiementType.nope)
//         .where((t) => t.herderId == herder.id.toString());
//     for (final ticket in spendTicketsPerHerder) {
//       for (final item in ticket.items) {
//         if (item.lots.length > 1) {
//           item.lots.forEach((element) => milkToday += 1);
//         } else {
//           milkToday += item?.quantity;
//         }
//       }
//     }
//     return milkToday;
//   }

//   double herderMilkVolumeThisMonth(DateTime date, Herder herder) {
//     var milkThisMonth = 0.0;
//     var spendTicketsPerHerder = where((t) => t.status == true)
//         .where(
//           (t) =>
//               t.date.isAfter(DateTime(date.year, date.month, 1, 1, 1)) &&
//               t.date.isBefore(
//                 DateTime(date.year, date.month,
//                     DateTime(date.year, date.month + 1, 0).day, 23, 59),
//               ),
//         )
//         .where((t) => t.ticketType == TicketType.spendDeferred)
//         .where((t) => t.herderId == '${herder.id}');
//     if (spendTicketsPerHerder != null && spendTicketsPerHerder.isNotEmpty) {
//       for (final ticket in spendTicketsPerHerder) {
//         for (final item in ticket.items) {
//           milkThisMonth += item?.quantity;
//         }
//       }
//     }
//     return milkThisMonth;
//   }

//   double computeHerderMilkThisMonthIncludingTicketsBeingMadeRightNow(
//       DateTime date, Herder herder, List<Ticket> lightningTickets) {
//     var milkThisMonth = 0.0;
//     final temp = where((t) => t.status == true)
//         .where((t) => t.date.year == date.year && t.date.month == date.month)
//         .where((t) => t.ticketType == TicketType.spendDeferred)
//         .where((t) => t.paiementType == PaiementType.nope)
//         .where((t) => t.herderId == '${herder.id}');
//     //print('spendTicketsPerHerder ${spendTicketsPerHerder.length}');
//     final spendTicketsPerHerder = temp.toList()..addAll(lightningTickets);

//     //print('spendTicketsPerHerder ${lightninglength}');
//     //print('spendTicketsPerHerder ${spendTicketsPerHerder.length}');
//     if (spendTicketsPerHerder != null && spendTicketsPerHerder.isNotEmpty) {
//       for (final ticket in spendTicketsPerHerder) {
//         for (final item in ticket.items) {
//           if (item.lots.length > 1) {
//             item.lots.forEach((element) => milkThisMonth += 1);
//           } else {
//             milkThisMonth += item?.quantity;
//           }
//         }
//       }
//     }
//     return milkThisMonth;
//   }

//   double herderTotalQuota(int herderId) {
//     return where((t) => t.status == true)
//         .where((t) => t.herderId == '$herderId' && t.status)
//         .where((t) =>
//             t.date.isAfter(DateTime(0).thisMonthFirstDay()) &&
//             t.date.isBefore(DateTime(0).thisMonthLastDay()))
//         .where((element) => element.ticketType == TicketType.spendDeferred)
//         .fold(
//             0.0,
//             (p, element) =>
//                 p +
//                 element.items
//                     .where((e) => e.article.id == 1)
//                     .fold(0, (prev, val) => prev + (val?.quantity ?? 0)));
//   }

//   double herderNoQuota(int herderId) {
//     return where((t) => t.herderId == '$herderId')
//         .where((t) =>
//             t.date.isAfter(DateTime(0).thisMonthFirstDay()) &&
//             t.date.isBefore(DateTime(0).thisMonthLastDay()))
//         .where((element) => element.ticketType == TicketType.spendDeferred)
//         .fold(
//             0.0,
//             (p, element) =>
//                 p +
//                 element.items.where((e) => e.article.id == 2)?.fold(
//                     0.0, (prev, val) => (prev ?? 0) + (val?.quantity ?? 0)));
//   }

//   //* STOCK in stats

//   double dayStockInProduct(
//       DateTime date, Product product, List<Shop> dashboardShops) {
//     double stockCount = 0.0;
//     if (dashboardShops.isNotEmpty) {
//       for (final shop in dashboardShops) {
//         stockCount += where((t) => t.status)
//             .where((t) =>
//                 t.date.year == date.year &&
//                 t.date.month == date.month &&
//                 t.date.day == date.day)
//             .where((t) => t.items.isNotEmpty)
//             .where((t) => t.shopUuid == shop.uuid)
//             .where((t) =>
//                 t.ticketType == TicketType.spend ||
//                 t.ticketType == TicketType.spendDeferred ||
//                 t.ticketType == TicketType.stockIn)
//             .fold(
//                 0.0,
//                 (prev, ticket) =>
//                     prev +
//                     ticket.items
//                         .where((i) =>
//                             //i.article.shopUuid == product.shopUuid &&
//                             i.article.productId == product.id)
//                         .fold(
//                             0.0,
//                             (prev, i) =>
//                                 prev + (i.quantity * i.article.weight)));
//       }
//     }
//     return stockCount;
//   }

//   double dayStockOutProduct(
//       DateTime date, Product product, List<Shop> dashboardShops) {
//     double stockCount = 0.0;
//     if (dashboardShops.isNotEmpty) {
//       for (final shop in dashboardShops) {
//         stockCount += where((t) => t.status)
//             .where((t) =>
//                 t.date.year == date.year &&
//                 t.date.month == date.month &&
//                 t.date.day == date.day)
//             .where((t) => t.items.isNotEmpty)
//             .where((t) => t.shopUuid == shop.uuid)
//             .where((t) =>
//                 t.ticketType == TicketType.sell ||
//                 t.ticketType == TicketType.sellDeferred ||
//                 t.ticketType == TicketType.stockOut)
//             .fold(
//                 0.0,
//                 (prev, ticket) =>
//                     prev +
//                     ticket.items
//                         .where((i) =>
//                             //i.article.shopUuid == product.shopUuid &&
//                             i.article.productId == product.id)
//                         .fold(
//                             0.0,
//                             (prev, i) =>
//                                 prev + (i.quantity * i.article.weight)));
//       }
//     }
//     return stockCount;
//   }

//   double dayStockInArticle(
//       DateTime date, Article article, List<Shop> dashboardShops) {
//     double stockCount = 0.0;
//     if (dashboardShops.isNotEmpty) {
//       for (final shop in dashboardShops) {
//         stockCount += where((t) => t.status)
//             .where((t) =>
//                 t.date.year == date.year &&
//                 t.date.month == date.month &&
//                 t.date.day == date.day)
//             .where((t) => t.items.isNotEmpty)
//             .where((t) => t.shopUuid == shop.uuid)
//             .where((t) =>
//                 t.ticketType == TicketType.spend ||
//                 t.ticketType == TicketType.spendDeferred ||
//                 t.ticketType == TicketType.stockIn)
//             .fold(
//               0.0,
//               (prev, ticket) =>
//                   prev +
//                   ticket.items
//                       .where((i) =>
//                           //i.article.shopUuid == article.shopUuid &&
//                           i.article.productId == article.productId &&
//                           i.article.id == article.id)
//                       .fold(0,
//                           (prev, i) => prev + (i.quantity * i.article.weight)),
//             );
//       }
//     }
//     return stockCount;
//   }

//   double dayStockOutArticle(
//       DateTime date, Article article, List<Shop> dashboardShops) {
//     double stockCount = 0.0;
//     if (dashboardShops.isNotEmpty) {
//       for (final shop in dashboardShops) {
//         stockCount += where((t) => t.status)
//             .where((t) =>
//                 t.date.year == date.year &&
//                 t.date.month == date.month &&
//                 t.date.day == date.day)
//             .where((t) => t.shopUuid == shop.uuid)
//             .where((t) => t.items.isNotEmpty)
//             .where((t) =>
//                 t.ticketType == TicketType.sell ||
//                 t.ticketType == TicketType.sellDeferred ||
//                 t.ticketType == TicketType.stockOut)
//             .fold(
//                 0.0,
//                 (prev, ticket) =>
//                     prev +
//                     ticket.items
//                         .where((i) =>
//                             //i.article.shopUuid == article.shopUuid &&
//                             i.article.productId == article.productId &&
//                             i.article.id == article.id)
//                         .fold(
//                             0,
//                             (prev, i) =>
//                                 prev + (i.quantity * i.article.weight)));
//       }
//     }
//     return stockCount;
//   }

//   double monthStockInProduct(
//       DateTime date, Product product, List<Shop> dashboardShops) {
//     double stockCount = 0.0;
//     if (dashboardShops.isNotEmpty) {
//       for (final shop in dashboardShops) {
//         stockCount += where((t) => t.status)
//             .where(
//                 (t) => t.date.year == date.year && t.date.month == date.month)
//             .where((t) => t.items.isNotEmpty)
//             .where((t) => t.shopUuid == shop.uuid)
//             .where((t) =>
//                 t.ticketType == TicketType.spend ||
//                 t.ticketType == TicketType.spendDeferred ||
//                 t.ticketType == TicketType.stockIn)
//             .fold(
//                 0.0,
//                 (prev, ticket) =>
//                     prev +
//                     ticket.items
//                         .where((i) =>
//                             //i.article.shopUuid == product.shopUuid &&
//                             i.article.productId == product.id)
//                         .fold(
//                             0.0,
//                             (prev, i) =>
//                                 prev + (i.quantity * i.article.weight)));
//       }
//     }
//     return stockCount;
//   }

//   double monthStockOutProduct(
//       DateTime date, Product product, List<Shop> dashboardShops) {
//     double stockCount = 0.0;
//     if (dashboardShops.isNotEmpty) {
//       for (final shop in dashboardShops) {
//         stockCount += where((t) => t.status)
//             .where(
//                 (t) => t.date.year == date.year && t.date.month == date.month)
//             .where((t) => t.items.isNotEmpty)
//             .where((t) => t.shopUuid == shop.uuid)
//             .where((t) =>
//                 t.ticketType == TicketType.sell ||
//                 t.ticketType == TicketType.sellDeferred ||
//                 t.ticketType == TicketType.stockOut)
//             .fold(
//                 0.0,
//                 (prev, ticket) =>
//                     prev +
//                     ticket.items
//                         .where((i) =>
//                             //i.article.shopUuid == product.shopUuid &&
//                             i.article.productId == product.id)
//                         .fold(
//                             0.0,
//                             (prev, i) =>
//                                 prev + (i.quantity * i.article.weight)));
//       }
//     }
//     return stockCount;
//   }

//   double monthStockInArticle(
//       DateTime date, Article article, List<Shop> dashboardShops) {
//     double stockCount = 0.0;
//     if (dashboardShops.isNotEmpty) {
//       for (final shop in dashboardShops) {
//         stockCount += where((t) => t.status)
//             .where(
//                 (t) => t.date.year == date.year && t.date.month == date.month)
//             .where((t) => t.items.isNotEmpty)
//             .where((t) => t.shopUuid == shop.uuid)
//             .where((t) =>
//                 t.ticketType == TicketType.spend ||
//                 t.ticketType == TicketType.spendDeferred ||
//                 t.ticketType == TicketType.stockIn)
//             .fold(
//                 0.0,
//                 (prev, ticket) =>
//                     prev +
//                     ticket.items
//                         .where((i) =>
//                             i.article.productId == article.productId &&
//                             i.article.id == article.id)
//                         .fold(
//                             0.0,
//                             (prev, i) =>
//                                 prev + (i.quantity * i.article.weight)));
//       }
//     }
//     return stockCount;
//   }

//   double monthStockOutArticle(
//       DateTime date, Article article, List<Shop> dashboardShops) {
//     double stockCount = 0.0;
//     if (dashboardShops.isNotEmpty) {
//       for (final shop in dashboardShops) {
//         stockCount += where((t) => t.status)
//             .where(
//                 (t) => t.date.year == date.year && t.date.month == date.month)
//             .where((t) => t.shopUuid == shop.uuid)
//             .where((t) => t.items.isNotEmpty)
//             .where((t) =>
//                 t.ticketType == TicketType.sell ||
//                 t.ticketType == TicketType.sellDeferred ||
//                 t.ticketType == TicketType.stockOut)
//             .fold(
//                 0.0,
//                 (prev, ticket) =>
//                     prev +
//                     ticket.items
//                         .where((i) =>
//                             //i.article.shopUuid == article.shopUuid &&
//                             i.article.productId == article.productId &&
//                             i.article.id == article.id)
//                         .fold(
//                             0.0,
//                             (prev, i) =>
//                                 prev + (i.quantity * i.article.weight)));
//       }
//     }
//     return stockCount;
//   }

//   double rangeStockInProduct(DateTime firstDate, DateTime lastDate,
//       Product product, List<Shop> dashboardShops) {
//     // ! no need to pass list of shops
//     // shopUuid string are enough
//     double stockCount = 0.0;
//     if (dashboardShops.isNotEmpty) {
//       for (final shop in dashboardShops) {
//         stockCount += where((t) => t.status)
//             .where((t) => t.date.isAfter(firstDate))
//             .where((t) => t.date.isBefore(lastDate))
//             .where((t) => t.shopUuid == shop.uuid)
//             .where((t) => t.items.isNotEmpty)
//             .where((t) =>
//                 t.ticketType == TicketType.spend ||
//                 t.ticketType == TicketType.spendDeferred ||
//                 t.ticketType == TicketType.stockIn)
//             .fold(
//                 0.0,
//                 (prev, ticket) =>
//                     prev +
//                     ticket.items
//                         .where((i) => i.article.productId == product.id)
//                         .fold(
//                             0.0,
//                             (prev, i) =>
//                                 prev + (i.quantity * i.article.weight)));
//       }
//     }
//     return stockCount;
//   }

//   double rangeStockOutProduct(DateTime firstDate, DateTime lastDate,
//       Product product, List<Shop> dashboardShops) {
//     double stockCount = 0.0;
//     if (dashboardShops.isNotEmpty) {
//       for (final shop in dashboardShops) {
//         stockCount += where((t) => t.status)
//             .where((t) => t.date.isAfter(firstDate))
//             .where((t) => t.date.isBefore(lastDate))
//             .where((t) => t.shopUuid == shop.uuid)
//             .where((t) => t.items.isNotEmpty)
//             .where((t) =>
//                 t.ticketType == TicketType.sell ||
//                 t.ticketType == TicketType.sellDeferred ||
//                 t.ticketType == TicketType.stockOut)
//             .fold(
//                 0.0,
//                 (prev, ticket) =>
//                     prev +
//                     ticket.items
//                         .where((i) => i.article.productId == product.id)
//                         .fold(
//                             0.0,
//                             (prev, i) =>
//                                 prev + (i.quantity * i.article.weight)));
//       }
//     }
//     return stockCount;
//   }

//   double rangeStockInArticle(DateTime firstDate, DateTime lastDate,
//       Article article, List<Shop> dashboardShops) {
//     double stockCount = 0.0;
//     if (dashboardShops.isNotEmpty) {
//       for (final shop in dashboardShops) {
//         stockCount += where((t) => t.status)
//             .where((t) => t.date.isAfter(firstDate))
//             .where((t) => t.date.isBefore(lastDate))
//             .where((t) => t.shopUuid == shop.uuid)
//             .where((t) => t.items.isNotEmpty)
//             .where((t) =>
//                 t.ticketType == TicketType.spend ||
//                 t.ticketType == TicketType.spendDeferred ||
//                 t.ticketType == TicketType.stockIn)
//             .fold(
//                 0,
//                 (prev, ticket) =>
//                     prev +
//                     ticket.items
//                         .where((i) =>
//                             i.article.productId == article.productId &&
//                             i.article.id == article.id)
//                         .fold(
//                             0,
//                             (prev, i) =>
//                                 prev + (i.quantity * i.article.weight)));
//       }
//     }
//     return stockCount;
//   }

//   double rangeStockOutArticle(DateTime firstDate, DateTime lastDate,
//       Article article, List<Shop> dashboardShops) {
//     double stockCount = 0.0;
//     if (dashboardShops.isNotEmpty) {
//       for (final shop in dashboardShops) {
//         stockCount += where((t) => t.status)
//             .where((t) => t.date.isAfter(firstDate))
//             .where((t) => t.date.isBefore(lastDate))
//             .where((t) => t.shopUuid == shop.uuid)
//             .where((t) => t.items.isNotEmpty)
//             .where((t) =>
//                 t.ticketType == TicketType.sell ||
//                 t.ticketType == TicketType.sellDeferred ||
//                 t.ticketType == TicketType.stockOut)
//             .fold(
//                 0,
//                 (prev, ticket) =>
//                     prev +
//                     ticket.items
//                         .where((i) =>
//                             //i.article.shopUuid == article.shopUuid &&
//                             i.article.productId == article.productId &&
//                             i.article.id == article.id)
//                         .fold(
//                             0,
//                             (prev, i) =>
//                                 prev + (i.quantity * i.article.weight)));
//       }
//     }
//     return stockCount;
//   }

// // * below stock new functions
//   Observable<double> productQuantityOut(
//       int productId, List<Shop> dashboardShops) {
//     double stockCount = 0.0;
//     if (dashboardShops.isNotEmpty) {
//       for (final shop in dashboardShops) {
//         stockCount += where((t) => t.shopUuid == shop.uuid)
//             .where((t) => t.status == true)
//             .where((t) =>
//                 t.ticketType == TicketType.sell ||
//                 t.ticketType == TicketType.sellDeferred ||
//                 t.ticketType == TicketType.stockOut)
//             .fold(
//               0.0,
//               (val, t) =>
//                   val +
//                   t.items.where((i) => i.article.productId == productId).fold(
//                       0.0, (val, i) => val + (i.quantity * i.article.weight)),
//             );
//       }
//     }
//     return Observable(stockCount);
//   }

//   Observable<double> productQuantityOutDash(
//       int productId, List<Shop> dashboardShops, DateTimeRange range) {
//     double stockCount = 0.0;
//     if (dashboardShops.isNotEmpty) {
//       for (final shop in dashboardShops) {
//         stockCount += where((t) => t.shopUuid == shop.uuid)
//             .where((t) => t.status == true)
//             .where((t) => t.date.isAfter(range.start))
//             .where((t) => t.date.isBefore(range.end))
//             .where((t) =>
//                 t.ticketType == TicketType.sell ||
//                 t.ticketType == TicketType.sellDeferred ||
//                 t.ticketType == TicketType.stockOut)
//             .fold(
//               0.0,
//               (val, t) =>
//                   val +
//                   t.items.where((i) => i.article.productId == productId).fold(
//                       0.0, (val, i) => val + (i.quantity * i.article.weight)),
//             );
//       }
//     }
//     return Observable(stockCount);
//   }

//   Observable<double> productQuantityIn(
//       int productId, List<Shop> dashboardShops) {
//     double stockCount = 0.0;
//     if (dashboardShops.isNotEmpty) {
//       for (final shop in dashboardShops) {
//         stockCount += where((t) => t.status)
//             .where((t) => t.shopUuid == shop.uuid)
//             .where((t) =>
//                 t.ticketType == TicketType.spend ||
//                 t.ticketType == TicketType.spendDeferred ||
//                 t.ticketType == TicketType.stockIn)
//             .fold(
//                 0.0,
//                 (val, t) =>
//                     val +
//                     t.items.where((i) => i.article.productId == productId).fold(
//                         0.0,
//                         (val, i) => val + (i.quantity * i.article.weight)));
//       }
//     }
//     return Observable(stockCount);
//   }

//   Observable<double> productQuantityInDash(
//       int productId, List<Shop> dashboardShops, DateTimeRange range) {
//     double stockCount = 0.0;
//     if (dashboardShops.isNotEmpty) {
//       for (final shop in dashboardShops) {
//         stockCount += where((t) => t.status)
//             .where((t) => t.shopUuid == shop.uuid)
//             .where((t) => t.date.isAfter(range.start))
//             .where((t) => t.date.isBefore(range.end))
//             .where((t) =>
//                 t.ticketType == TicketType.spend ||
//                 t.ticketType == TicketType.spendDeferred ||
//                 t.ticketType == TicketType.stockIn)
//             .fold(
//                 0.0,
//                 (val, t) =>
//                     val +
//                     t.items.where((i) => i.article.productId == productId).fold(
//                         0.0,
//                         (val, i) => val + (i.quantity * i.article.weight)));
//       }
//     }
//     return Observable(stockCount);
//   }

//   Observable<double> articleQuantityOut(
//       int productId, int articleId, List<Shop> dashboardShops) {
//     double stockCount = 0.0;
//     if (dashboardShops.isNotEmpty) {
//       for (final shop in dashboardShops) {
//         stockCount += where((t) => t.status)
//             .where((t) => t.shopUuid == shop.uuid)
//             .where((t) =>
//                 t.ticketType == TicketType.sell ||
//                 t.ticketType == TicketType.sellDeferred ||
//                 t.ticketType == TicketType.stockOut)
//             .fold(
//               0.0,
//               (val, t) =>
//                   val +
//                   t.items
//                       .where((i) => i.article.productId == productId)
//                       .where((i) => i.article.id == articleId)
//                       .fold(0.0,
//                           (val, i) => val + (i.quantity * i.article.weight)),
//             );
//       }
//     }
//     return Observable(stockCount);
//   }

//   Observable<double> articleQuantityOutDash(int productId, int articleId,
//       List<Shop> dashboardShops, DateTimeRange range) {
//     double stockCount = 0.0;
//     if (dashboardShops.isNotEmpty) {
//       for (final shop in dashboardShops) {
//         stockCount += where((t) => t.status)
//             .where((t) => t.shopUuid == shop.uuid)
//             .where((t) => t.date.isAfter(range.start))
//             .where((t) => t.date.isBefore(range.end))
//             .where((t) =>
//                 t.ticketType == TicketType.sell ||
//                 t.ticketType == TicketType.sellDeferred ||
//                 t.ticketType == TicketType.stockOut)
//             .fold(
//               0.0,
//               (val, t) =>
//                   val +
//                   t.items
//                       .where((i) => i.article.productId == productId)
//                       .where((i) => i.article.id == articleId)
//                       .fold(0.0,
//                           (val, i) => val + (i.quantity * i.article.weight)),
//             );
//       }
//     }
//     return Observable(stockCount);
//   }

//   Observable<double> articleQuantityIn(
//       int productId, int articleId, List<Shop> dashboardShops) {
//     double stockCount = 0.0;
//     if (dashboardShops.isNotEmpty) {
//       for (final shop in dashboardShops) {
//         stockCount += where((t) => t.status)
//             .where((t) => t.shopUuid == shop.uuid)
//             .where((t) =>
//                 t.ticketType == TicketType.spend ||
//                 t.ticketType == TicketType.spendDeferred ||
//                 t.ticketType == TicketType.stockIn)
//             .fold(
//               0.0,
//               (val, t) =>
//                   val +
//                   t.items
//                       .where((i) => i.article.productId == productId)
//                       .where((i) => i.article.id == articleId)
//                       .fold(0.0,
//                           (val, i) => val + (i.quantity * i.article.weight)),
//             );
//       }
//     }
//     return Observable(stockCount);
//   }

//   Observable<double> articleQuantityInDash(int productId, int articleId,
//       List<Shop> dashboardShops, DateTimeRange range) {
//     double stockCount = 0.0;
//     if (dashboardShops.isNotEmpty) {
//       for (final shop in dashboardShops) {
//         stockCount += where((t) => t.status)
//             .where((t) => t.shopUuid == shop.uuid)
//             .where((t) =>
//                 t.ticketType == TicketType.spend ||
//                 t.ticketType == TicketType.spendDeferred ||
//                 t.ticketType == TicketType.stockIn)
//             .fold(
//               0.0,
//               (val, t) =>
//                   val +
//                   t.items
//                       .where((i) => i.article.productId == productId)
//                       .where((i) => i.article.id == articleId)
//                       .fold(0.0,
//                           (val, i) => val + (i.quantity * i.article.weight)),
//             );
//       }
//     }
//     return Observable(stockCount);
//   }

// // below is bound to disappear

//   double lotQuantityOut(Lot lot) {
//     return where((t) => t.status == true)
//         //* filtering by ticketShopUuid might be irrelevant for stock out / in
//         // and it is also refiltered after
//         // so not using where((t) => t.shopUuid == lot.shopUuid)
//         .where((t) =>
//             t.ticketType == TicketType.sell ||
//             t.ticketType == TicketType.sellDeferred ||
//             t.ticketType == TicketType.stockOut)
//         .fold(
//             0.0,
//             (prev, ticket) =>
//                 prev +
//                 ticket.items
//                     .where((i) =>
//                         i.article.productId == lot.productId &&
//                         i.article.id == lot.articleId &&
//                         i.lots.any((element) => element.id == lot.id))
//                     .fold(0.0, (prev, item) => prev + item.quantity));
//   }

//   // below is bound to disappear
//   List<Ticket> lotsMatchingTicket(Lot lot) {
//     List<Ticket> lotTickets = [];
//     for (final _ticket in this) {
//       for (final _item in _ticket.items) {
//         for (final _lot in _item.lots) {
//           if (_lot.productId == lot.productId &&
//               _lot.articleId == lot.articleId &&
//               _lot.id == lot.id) {
//             if (lotTickets.any((element) =>
//                 element.creationDate.isAtSameMomentAs(_ticket.creationDate))) {
//               // do not add if alrady in
//             } else {
//               lotTickets.add(_ticket);
//               //print("print lot added");
//             }
//           }
//         }
//       }
//     }
//     return lotTickets.toList();
//   }

//   // below is bound to disappear
//   double lotInitialQt(Lot lot) {
//     double lotInitQt = 0.0;
//     //print("1st length ${lotsMatchingTicket(lot).length}");
//     final lotTickets = lotsMatchingTicket(lot);

//     final superLotTickets = lotTickets
//         .where((t) => t.status == true)
//         .where((element) =>
//             element.ticketType == TicketType.spend ||
//             element.ticketType == TicketType.spendDeferred ||
//             element.ticketType == TicketType.stockIn)
//         .toList();
//     //  only + stock, no exit
//     if (superLotTickets.isNotEmpty) {
//       for (final _ticket in superLotTickets) {
//         lotInitQt += _ticket.items
//             .where((i) =>
//                 i.article.productId == lot.productId &&
//                 i.article.id == lot.articleId &&
//                 i.lots.any((element) => element.id == lot.id))
//             .fold(
//                 0.0,
//                 (prev, item) => item.lots.length == 1 && item.quantity > 1
//                     ? prev + item.quantity
//                     : prev +
//                         item.lots
//                             .where((l) =>
//                                 l.id == lot.id &&
//                                 l.articleId == lot.articleId &&
//                                 l.productId == lot.productId)
//                             .length);
//       }
//     }
//     return lotInitQt;
//   }
// // below full stock customized version
// // there might be an smarter way to do it but it late

//   double productQuantityOutShopLess(Product product) =>
//       where((t) => t.status == true)
//           //.where((t) => t.shopUuid == product.shopUuid)
//           .where((t) =>
//               t.ticketType == TicketType.sell ||
//               t.ticketType == TicketType.sellDeferred ||
//               t.ticketType == TicketType.stockOut)
//           .fold(
//             0.0,
//             (val, t) =>
//                 val +
//                 t.items.where((i) => i.article.productId == product.id).fold(
//                     0.0, (val, i) => val + (i.quantity * i.article.weight)),
//           );

//   double productQuantityInShopLess(Product product) =>
//       where((t) => t.status == true)
//           //.where((t) => t.shopUuid == product.shopUuid)
//           .where((t) =>
//               t.ticketType == TicketType.spend ||
//               t.ticketType == TicketType.spendDeferred ||
//               t.ticketType == TicketType.stockIn)
//           .fold(
//               0.0,
//               (val, t) =>
//                   val +
//                   t.items.where((i) => i.article.productId == product.id).fold(
//                       0.0, (val, i) => val + i.quantity * i.article.weight));

//   double productQuantityOutFullStockUnbreakable(Product product, Shop shop) =>
//       where((t) => t.status == true && t.shopUuid == shop.uuid)
//           .where((t) =>
//               t.ticketType == TicketType.sell ||
//               t.ticketType == TicketType.sellDeferred ||
//               t.ticketType == TicketType.stockOut)
//           .fold(
//             0.0,
//             (val, t) =>
//                 val +
//                 t.items
//                     .where((i) =>
//                         //i.article.shopUuid == shop.uuid
//                         i.article.productId == product.id)
//                     .fold(
//                         0.0, (val, i) => val + (i.quantity) * i.article.weight),
//           );

//   double productQuantityInFullStockUnbreakable(Product product, Shop shop) =>
//       where((t) => t.status == true)
//           .where((t) => t.shopUuid == shop.uuid)
//           .where((t) =>
//               t.ticketType == TicketType.spend ||
//               t.ticketType == TicketType.spendDeferred ||
//               t.ticketType == TicketType.stockIn)
//           .fold(
//               0.0,
//               (val, t) =>
//                   val +
//                   t.items.where((i) => i.article.productId == product.id).fold(
//                       0.0, (val, i) => val + (i.quantity * i.article.weight)));
// }
