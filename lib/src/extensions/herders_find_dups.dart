import 'package:models_weebi/src/models/utils/two_lists.dart';
import 'package:models_weebi/weebi_models.dart';

extension HerderFindDups on List<Herder> {
  TwoLists<Herder> findDupsById({required List<Herder> newList}) {
    if (isEmpty) {
      return TwoLists(noDups: newList, dups: <Herder>[]);
    }
    final oldListIds = map((e) => e.id);
    final newListIds = map((e) => e.id);
    final noDups = <Herder>[];
    final dups = <Herder>[];
    for (final newId in newListIds) {
      if (oldListIds.contains(newId) == false) {
        noDups.add(newList.firstWhere((e) => e.id == newId));
      } else {
        dups.add(newList.firstWhere((e) => e.id == newId));
      }
    }

    return TwoLists(noDups: noDups, dups: dups);
  }

  TwoLists<Herder> findDupsByFields({required List<Herder> newList}) {
    if (isEmpty) {
      return TwoLists(noDups: newList, dups: <Herder>[]);
    }
    final listNoDups = <Herder>[];
    final listDups = <Herder>[];

    Map<int, Herder> mapOldFullName = {};
    Map<int, Herder> mapOldTel = {};
    Map<int, Herder> mapOldMail = {};
    // print('oldList.length ${oldList.length}');
    // print('this.length $length');
    for (var oldH in this) {
      mapOldFullName[oldH.fullNameHash] = oldH;
      mapOldTel[oldH.telHash] = oldH;
      mapOldMail[oldH.mailHash] = oldH;
    }
    for (var newH in newList) {
      if ((newH.tel.isNotEmpty && mapOldTel.keys.contains(newH.telHash))) {
        // on trie sur le tel ou sur le mail et ajoute ceux qui correspondent
        newH = newH.copyWith(id: mapOldTel[newH.telHash]!.id);
        listDups.add(newH);
      } else if ((newH.mail.isNotEmpty &&
          mapOldMail.keys.contains(newH.mailHash))) {
        newH = newH.copyWith(id: mapOldMail[newH.mailHash]!.id);
        listDups.add(newH);
      } else {
        // sur les autres on vérifie le nomComplet
        if (newH.fullName.isNotEmpty &&
            mapOldFullName.keys.contains(newH.fullNameHash)) {
          newH = newH.copyWith(id: mapOldFullName[newH.fullNameHash]!.id);
          listDups.add(newH);
        } else {
          // on ajoute ceux qui ne correspondent pas
          // l\'id a déjà été ajouté
          listNoDups.add(newH);
        }
      }
    }

    return TwoLists<Herder>(dups: listDups, noDups: listNoDups);
  }
}
