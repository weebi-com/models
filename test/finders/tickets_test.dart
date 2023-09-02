import 'package:models_weebi/extensions_tickets.dart';
import 'package:models_weebi/weebi_models.dart';
import 'package:test/test.dart';

void main() {
  test('tickets finders', () {
    final tickets = {TicketWeebi.dummySell, TicketWeebi.dummySpend};
    final herders = {Herder.defaultHerder, Herder.dummy, Herder.dummy2};
    final ticketsIds = tickets.findTicketsWithHerderNameOrTel('Jimmy', herders);
    final ticketsFound = tickets.idsToTickets(ticketsIds);
    expect(ticketsFound.length, 1);
    expect(ticketsFound.first.contactId, 2);
  });
}
