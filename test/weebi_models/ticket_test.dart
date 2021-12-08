import 'package:models_weebi/src/weebi/ticket_weebi.dart';
import 'package:test/test.dart';

void main() {
  test('ticket weebi', () {
    final _json = TicketWeebi.dummy.toJson();
    final dummy = TicketWeebi.fromJson(_json);
    expect(dummy == TicketWeebi.dummy, isTrue);
  });
}
