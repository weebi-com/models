import 'package:models_weebi/src/models/utils/two_lists.dart';
import 'package:models_weebi/weebi_models.dart';

extension HerderFindDups on List<Herder> {
  TwoLists<Herder> findDups({required List<Herder> oldList}) {
    final listNoDups = <Herder>[];
    final listDups = <Herder>[];
    if (oldList.length < length) {
      Map<int, Herder> mapOldFullName = {};
      Map<int, Herder> mapOldTel = {};
      Map<int, Herder> mapOldMail = {};

      for (var h in oldList) {
        mapOldFullName[h.fullNameHash] = h;
        mapOldTel[h.telHash] = h;
        mapOldMail[h.mailHash] = h;
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
          }
        }
      }
      return TwoLists<Herder>(dups: listDups, noDups: listNoDups);
    } else {
      // if oldList is longer, iterate over it brings better performance if
      Map<int, Herder> mapNewFullName = {};
      Map<int, Herder> mapNewTel = {};
      Map<int, Herder> mapNewMail = {};

      for (var h in this) {
        mapNewFullName[h.fullNameHash] = h;
        mapNewTel[h.telHash] = h;
        mapNewMail[h.mailHash] = h;
      }

      for (var h in oldList) {
        if ((h.tel.isNotEmpty && mapNewTel.keys.contains(h.telHash)) ||
            (h.mail.isNotEmpty && mapNewMail.keys.contains(h.mailHash))) {
          // on trie sur le tel ou sur le mail et ajoute ceux qui correspondent
          listDups.add(h);
        } else {
          // sur les autres on vérifie le nomComplet
          if (h.fullName.isNotEmpty &&
              mapNewFullName.keys.contains(h.fullNameHash)) {
            listDups.add(h);
          } else {
            // on ajoute ceux qui ne correspondent pas
            listNoDups.add(h);
          }
        }
      }
      return TwoLists<Herder>(dups: listDups, noDups: listNoDups);
    }
  }
}
