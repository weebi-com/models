import 'package:models_weebi/utils.dart';
import 'package:models_weebi/weebi_models.dart';

extension FindDups on List<ArticleCalibre> {
  TwoLists<ArticleCalibre> findDupsById(
      {required List<ArticleCalibre> newList}) {
    final noDups = <ArticleCalibre>[];
    final dups = <ArticleCalibre>[];
    if (isEmpty) {
      noDups.addAll(newList);
      return TwoLists<ArticleCalibre>(dups: dups, noDups: noDups);
    }
    final oldListIds = map((e) => e.id);
    final newListIds = map((e) => e.id);
    for (final newId in newListIds) {
      if (oldListIds.contains(newId)) {
        dups.add(newList.firstWhere((e) => e.id == newId));
      } else {
        noDups.add(newList.firstWhere((e) => e.id == newId));
      }
    }
    return TwoLists(noDups: noDups, dups: dups);
  }

  TwoLists<ArticleCalibre> findDupsByTitle(
      {required List<ArticleCalibre> newList}) {
    final noDups = <ArticleCalibre>[];
    final dups = <ArticleCalibre>[];

    if (isEmpty) {
      noDups.addAll(newList);
      return TwoLists<ArticleCalibre>(dups: dups, noDups: noDups);
    }
    Map<int, ArticleCalibre> mapOldTitles = {};
    for (var p in this) {
      mapOldTitles[p.titleHash] = p;
    }
    for (var a in newList) {
      if (mapOldTitles.keys.contains(a.titleHash)) {
        a = a.copyWith(id: mapOldTitles[a.titleHash]!.id)
          ..copyWith(creationDate: mapOldTitles[a.titleHash]!.creationDate);
        dups.add(a);
      } else {
        noDups.add(a);
      }
    }
    return TwoLists<ArticleCalibre>(dups: dups, noDups: noDups);
  }
}
