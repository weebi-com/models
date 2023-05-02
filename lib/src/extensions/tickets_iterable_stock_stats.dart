import 'package:models_weebi/base.dart';
import 'package:models_weebi/extensions.dart';
import 'package:models_weebi/utils.dart';
import 'package:models_weebi/weebi_models.dart';

// preparing for null safe yobi
// also a few ready to use extensions for weebi
extension StockTickets<T extends TicketWeebi> on Iterable<T> {
  double stockLineInput(ArticleLine line, {DateRange? range}) {
    double stockCount = 0.0;
    for (final ticket in this) {
      if (ticket.status) {
        //print('status cleared');
        if (ticket.date.isDateInDateRange(range ??
            DateRange(
                WeebiDates.defaultFirstDate, WeebiDates.defaultLastDate))) {
          //print('range cleared');
          if (ticket.ticketType.isShopInput) {
            //print('type cleared');
            if (ticket.items.isNotEmpty) {
              //print('items cleared');
              for (final item in ticket.items) {
                stockCount += item.getStockMovementForLine(line);
              }
            }
          }
        }
      }
    }
    return stockCount;
  }

  double stockLineOutput(ArticleLine line, {DateRange? range}) {
    double stockCount = 0.0;
    for (final ticket in this) {
      if (ticket.status) {
        if (ticket.date.isDateInDateRange(range ??
            DateRange(
                WeebiDates.defaultFirstDate, WeebiDates.defaultLastDate))) {
          if (ticket.ticketType.isShopOutput) {
            if (ticket.items.isNotEmpty) {
              for (final item in ticket.items) {
                stockCount += item.getStockMovementForLine(line);
              }
            }
          }
        }
      }
    }
    return stockCount;
  }

  double stockArticleInput<A extends ArticleAbstract>(A article,
      {DateRange? range}) {
    double stockCount = 0.0;
    for (final ticket in this) {
      if (ticket.status) {
        if (ticket.date.isDateInDateRange(range ??
            DateRange(
                WeebiDates.defaultFirstDate, WeebiDates.defaultLastDate))) {
          if (ticket.ticketType.isShopInput) {
            if (ticket.items.isNotEmpty) {
              for (final item in ticket.items) {
                stockCount += item.getStockMovementForArticle(article);
              }
            }
          }
        }
      }
    }
    return stockCount;
  }

  double stockArticleOutput<A extends ArticleAbstract>(A article,
      {DateRange? range}) {
    double stockCount = 0.0;
    for (final ticket in this) {
      if (ticket.status) {
        if (ticket.date.isDateInDateRange(range ??
            DateRange(
                WeebiDates.defaultFirstDate, WeebiDates.defaultLastDate))) {
          if (ticket.ticketType.isShopOutput) {
            if (ticket.items.isNotEmpty) {
              for (final item in ticket.items) {
                stockCount += item.getStockMovementForArticle(article);
              }
            }
          }
        }
      }
    }
    return stockCount;
  }
}
