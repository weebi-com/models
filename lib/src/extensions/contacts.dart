import 'package:models_weebi/weebi_models.dart' show ContactWeebi;

extension ContactsToRows on List<ContactWeebi> {
  List<List<dynamic>> formatToRows() {
    List<List<dynamic>> rows = List<List<dynamic>>.empty(growable: true);
    List<dynamic> contactsHeader = List.empty(growable: true);
    contactsHeader.add('id');
    contactsHeader.add('prenom');
    contactsHeader.add('nom');
    contactsHeader.add('tel');
    contactsHeader.add('mail');
    contactsHeader.add('adresse');
    contactsHeader.add('updateDate');
    contactsHeader.add('status');
    contactsHeader.add('statusUpdateDate');
    rows.add(contactsHeader);
    for (int i = 0; i < length; i++) {
      List<dynamic> cells = List.empty(growable: true);
      cells.add(this[i].id);
      cells.add(this[i].firstName);
      cells.add(this[i].lastName);
      cells.add(this[i].tel);
      cells.add(this[i].mail);
      cells.add(this[i].address);
      cells.add(this[i].updateDate.toString());
      cells.add(this[i].status);
      cells.add(this[i].statusUpdateDate.toString());
      rows.add(cells);
    }
    return rows;
  }
}
