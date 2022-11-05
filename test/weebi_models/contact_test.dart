import 'package:models_weebi/src/models/contact_weebi.dart';
import 'package:test/test.dart';

void main() {
  test('contactWeebi', () {
    final _json = ContactWeebi.dummy.toJson();
    final dummy = ContactWeebi.fromJson(_json);
    expect(dummy == ContactWeebi.dummy, isTrue);
    expect(dummy.address == ContactWeebi.dummy.address, isTrue);
    expect(ContactWeebi.dummy.isWoman == ContactWeebi.dummy.isWoman, isTrue);
    expect(
        ContactWeebi.dummy.firstName == ContactWeebi.dummy.firstName, isTrue);
    expect(ContactWeebi.dummy.lastName == ContactWeebi.dummy.lastName, isTrue);
    expect(ContactWeebi.dummy.mail == ContactWeebi.dummy.mail, isTrue);
    expect(ContactWeebi.dummy.creationDate == ContactWeebi.dummy.creationDate,
        isTrue);
  });
}
