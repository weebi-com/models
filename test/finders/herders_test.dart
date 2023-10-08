import 'package:models_weebi/src/models/herder.dart';
import 'package:test/test.dart';
import 'package:models_weebi/extensions.dart' show HerdersFinder;

void main() {
  test('herders finders', () {
    final herdersQuick = {Herder.defaultHerder, Herder.dummy, Herder.dummy2};
    final idsQuick = herdersQuick.findHerdersWithFullName('John Do');
    expect(idsQuick.length, 1);
    expect(idsQuick.first, 1);

    final herders = {Herder.defaultHerder, Herder.dummy, Herder.dummy2};
    final ids = herders.findHerdersWithFirstName('Jimmy');
    expect(ids.length, 1);
    expect(ids.first, 2);

    final ids2 = herders.findHerdersWithLastName('doe');
    expect(ids2.length, 2);
    expect(ids2.contains(1), isTrue);
    expect(ids2.contains(2), isTrue);

    final ids3 = herders.findHerdersWithTel('07800864');
    expect(ids3.length, 1);
    expect(ids3.first, 2);

    final ids4 = herders.findHerdersIdsWithNameOrTel('Jimmy');
    expect(ids4.length, 1);
    expect(ids4.first, 2);
  });
}
