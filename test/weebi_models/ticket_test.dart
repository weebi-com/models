import 'package:models_weebi/src/models/ticket_weebi.dart';
import 'package:test/test.dart';

void main() {
  test('ticket weebi', () {
    final _json = TicketWeebi.dummySell.toJson();
    final dummy = TicketWeebi.fromJson(_json);
    expect(dummy == TicketWeebi.dummySell, isTrue);
  });
}
