import 'package:models_weebi/src/models/ticket_weebi.dart';
import 'package:test/test.dart';

void main() {
  test('ticket weebi', () {
    final json = TicketWeebi.dummySell.toJson();
    final dummy = TicketWeebi.fromJson(json);
    expect(dummy == TicketWeebi.dummySell, isTrue);
  });
}
