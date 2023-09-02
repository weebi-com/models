import 'package:models_weebi/src/models/herder.dart';
import 'package:models_weebi/src/models/ticket_weebi.dart';
import 'package:models_weebi/extensions.dart' show HerdersFinder;

extension TicketsFinders<T extends TicketWeebi> on Iterable<T> {
  Set<int> findTicketsWithHerderNameOrTel<H extends Herder>(
      String queryString, Iterable<H> herders) {
    final herdersIds =
        herders.findHerdersIdsWithFirstNameOrLastNameOrTel(queryString);
    final fullSetOfIds = Set.of(<int>{});
    for (final ticket in this) {
      if (herdersIds.contains(ticket.contactId)) {
        fullSetOfIds.add(ticket.id);
      }
    }
    return fullSetOfIds;
  }

  Set<T> idsToTickets(Set<int> ids) {
    final _tickets = Set.of(<T>{});
    for (final ticket in this) {
      if (ids.contains(ticket.id)) {
        _tickets.add(ticket);
      }
    }
    return _tickets;
  }
}
