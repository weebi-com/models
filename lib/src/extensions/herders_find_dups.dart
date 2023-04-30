import 'package:models_weebi/src/models/utils/two_lists.dart';
import 'package:models_weebi/weebi_models.dart';

extension HerderFindDups on List<Herder> {
  TwoLists<Herder> findDups({required List<Herder> oldList}) {
    final listNoDups = <Herder>[];
    final listDups = <Herder>[];

    Map<int, Herder> mapOldFullName = {};
    Map<int, Herder> mapOldTel = {};
    Map<int, Herder> mapOldMail = {};
    // print('oldList.length ${oldList.length}');
    // print('this.length $length');
    for (var oldH in oldList) {
      mapOldFullName[oldH.fullNameHash] = oldH;
      mapOldTel[oldH.telHash] = oldH;
      mapOldMail[oldH.mailHash] = oldH;
    }
    for (var newH in this) {
      if ((newH.tel.isNotEmpty && mapOldTel.keys.contains(newH.telHash)) ||
          (newH.mail.isNotEmpty && mapOldMail.keys.contains(newH.mailHash))) {
        // on trie sur le tel ou sur le mail et ajoute ceux qui correspondent
        listDups.add(newH);
      } else {
        // sur les autres on vérifie le nomComplet
        if (newH.fullName.isNotEmpty &&
            mapOldFullName.keys.contains(newH.fullNameHash)) {
          listDups.add(newH);
        } else {
          // on ajoute ceux qui ne correspondent pas
          listNoDups.add(newH);
          // print('in listNoDups.add(newH);');
        }
      }
    }
    // print('listNoDups.length ${listNoDups.length}');
    // print('listDups.length ${listDups.length}');

    return TwoLists<Herder>(dups: listDups, noDups: listNoDups);
  }
}
