import 'package:models_weebi/common.dart';
import 'package:test/test.dart';

void main() {
  group('ticket_type', () {
    test('sell', () {
      final _json = {'ticketType': TicketType.sell.toString()};
      final tt = TicketType.tryParse(_json['ticketType'] ?? '');
      expect(tt == TicketType.sell, isTrue);
    });
  });
}
