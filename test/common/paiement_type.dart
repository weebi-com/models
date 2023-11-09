import 'package:models_weebi/common.dart';
import 'package:test/test.dart';

void main() {
  group('paiement_type', () {
    test('cash', () {
      final _json = {'paiementType': PaiementType.cash.toString()};
      // final Map<String, dynamic> map = (json.decode(_json));
      final pt = PaiementType.tryParse(_json['paiementType'] ?? '');
      expect(pt == PaiementType.cash, isTrue);
    });
    test('nope', () {
      final _json = {'paiementType': PaiementType.nope.toString()};
      final pt = PaiementType.tryParse(_json['paiementType'] ?? '');
      expect(pt == PaiementType.nope, isTrue);
    });
  });
}
