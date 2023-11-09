// import 'package:models_weebi/closing.dart';
// import 'package:models_weebi/reports.dart';
import 'package:models_weebi/common.dart' show FinFlow;
import 'package:models_weebi/utils.dart';
import 'package:models_weebi/weebi_models.dart';

extension FinFlowsTickets<T extends TicketWeebiAbstract> on List<T> {
  List<FinFlow> herderTkFinFlows(
      String herderId, DateRange dateRange, List<FinFlow> flows) {
    for (final ticket in this) {
      if (ticket.herderIdString == herderId && ticket.status == true) {
        if ((ticket.date.isAfter(dateRange.startDate) ||
                ticket.date.isAtSameMomentAs(dateRange.startDate)) &&
            (ticket.date.isBefore(dateRange.endDate) ||
                ticket.date.isAtSameMomentAs(dateRange.endDate))) {
          // no maintenance if financial new ticketTypes added
          if (flows.any((f) => f.type == '${ticket.ticketType}')) {
            final f = flows.firstWhere((f) => f.type == '${ticket.ticketType}');
            f.sumTickets += ticket.total;
          }
        }
      }
    }
    return flows;
  }

  List<FinFlow> shopTkFinFlows(
      String shopUuid, DateRange dateRange, List<FinFlow> flows) {
    where((t) => t.shopUuid == shopUuid)
        .where((t) => t.status)
        .forEach((ticket) {
      if ((ticket.date.isAfter(dateRange.startDate) ||
              ticket.date.isAtSameMomentAs(dateRange.startDate)) &&
          (ticket.date.isBefore(dateRange.endDate) ||
              ticket.date.isAtSameMomentAs(dateRange.endDate))) {
        if (flows.any((f) => f.type == '${ticket.ticketType}')) {
          final f = flows.firstWhere((f) => f.type == '${ticket.ticketType}');
          f.sumTickets += ticket.total;
        }
      }
    });
    return flows;
  }
}
