import 'package:models_base/base.dart' show TicketAbstract;

// package won't come down from github, shortcuting here

class TicketsGroupedByTimeFrame {
  final dynamic timeFrame;
  final List<TicketAbstract> tickets;
  TicketsGroupedByTimeFrame(this.timeFrame, this.tickets);
}

extension GroupTheseRascals on List<TicketAbstract> {
  List<TicketsGroupedByTimeFrame> groupByHour(
      DateTime dateStart, DateTime dateEnd) {
    final emptyGTickets = List<TicketsGroupedByTimeFrame>.generate(
        24, (index) => TicketsGroupedByTimeFrame(index + 1, []));
    for (final ticket in this) {
      if (ticket.date.isAfter(dateStart) && ticket.date.isBefore(dateEnd)) {
        if (emptyGTickets
            .any((element) => element.timeFrame == ticket.date.hour)) {
          final i = emptyGTickets
              .indexWhere((element) => element.timeFrame == ticket.date.day);
          emptyGTickets[i].tickets.add(ticket);
        } else {
          throw 'ticket ${ticket.toJson()} date is anormal in daily';
        }
      }
    }
    emptyGTickets.sort((a, b) => a.timeFrame.compareTo(b.timeFrame));
    return emptyGTickets;
  }

  List<TicketsGroupedByTimeFrame> groupByDayOfTheWeek(
      DateTime dateWeekStart, DateTime dateWeekEnd) {
    final mondayC = TicketsGroupedByTimeFrame(DateTime.monday, []);
    final tuesdayC = TicketsGroupedByTimeFrame(DateTime.tuesday, []);
    final wednesdayC = TicketsGroupedByTimeFrame(DateTime.wednesday, []);
    final thursdayC = TicketsGroupedByTimeFrame(DateTime.thursday, []);
    final fridayC = TicketsGroupedByTimeFrame(DateTime.friday, []);
    final saturdayC = TicketsGroupedByTimeFrame(DateTime.saturday, []);
    final sundayC = TicketsGroupedByTimeFrame(DateTime.sunday, []);
    for (final ticket in this) {
      if (ticket.date.isAfter(dateWeekStart) &&
          ticket.date.isBefore(dateWeekEnd)) {
        switch (ticket.date.weekday) {
          case DateTime.monday:
            mondayC.tickets.add(ticket);
            break;
          case DateTime.tuesday:
            tuesdayC.tickets.add(ticket);
            break;
          case DateTime.wednesday:
            wednesdayC.tickets.add(ticket);
            break;
          case DateTime.thursday:
            thursdayC.tickets.add(ticket);
            break;
          case DateTime.friday:
            fridayC.tickets.add(ticket);
            break;
          case DateTime.saturday:
            saturdayC.tickets.add(ticket);
            break;
          case DateTime.sunday:
            sundayC.tickets.add(ticket);
            break;
          default:
            throw 'ticket ${ticket.toJson()} date is anormal in weekly';
        }
      }
    }
    return [
      mondayC,
      tuesdayC,
      wednesdayC,
      thursdayC,
      fridayC,
      saturdayC,
      sundayC,
    ];
  }

  // stats lib does this naturally...
  List<TicketsGroupedByTimeFrame> groupByDayOfTheMonth(
      DateTime dateStart, DateTime dateEnd) {
    // below full month only, prefer flexibility : 15 days displayed for more accuracy
    //final start = dateStart.thisMonthFirstDay(dateStart);
    //final end = dateStart.thisMonthLastDay(dateStart);
    final daysDiff = dateEnd.difference(dateStart).inDays + 1;
    final emptyGTickets = List<TicketsGroupedByTimeFrame>.generate(
        daysDiff, (index) => TicketsGroupedByTimeFrame(index + 1, []));
    for (final ticket in this) {
      if (ticket.date.year == dateStart.year &&
          ticket.date.month == dateStart.month) {
        if (emptyGTickets
            .any((element) => element.timeFrame == ticket.date.day)) {
          final i = emptyGTickets
              .indexWhere((element) => element.timeFrame == ticket.date.day);
          emptyGTickets[i].tickets.add(ticket);
        } else {
          throw 'ticket ${ticket.toJson()} date is anormal in monthly';
        }
      }
    }
    emptyGTickets.sort((a, b) => a.timeFrame.compareTo(b.timeFrame));
    return emptyGTickets;
  }
}
