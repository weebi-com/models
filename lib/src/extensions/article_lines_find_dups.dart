import 'package:models_weebi/utils.dart';
import 'package:models_weebi/weebi_models.dart';

extension FindDups on List<ArticleLines> {
  TwoLists<ArticleLines> findDupsById({required List<ArticleLines> newList}) {
    final oldListIds = map((e) => e.id);
    final newListIds = map((e) => e.id);
    final noDups = <ArticleLines>[];
    final dups = <ArticleLines>[];
    for (final newId in newListIds) {
      if (oldListIds.contains(newId) == false) {
        noDups.add(firstWhere((e) => e.id == newId));
      } else {
        dups.add(firstWhere((e) => e.id == newId));
      }
    }
    return TwoLists(noDups: noDups, dups: dups);
  }

  TwoLists<ArticleLines> findDupsByTitle(
      {required List<ArticleLines> oldList}) {
    final noDups = <ArticleLines>[];
    final dups = <ArticleLines>[];

    Map<int, ArticleLines> mapOldTitles = {};
    for (var p in oldList) {
      mapOldTitles[p.titleHash] = p;
    }
    for (var a in this) {
      if (mapOldTitles.keys.contains(a.titleHash)) {
        a = a.copyWith(id: mapOldTitles[a.titleHash]!.id)
          ..copyWith(creationDate: mapOldTitles[a.titleHash]!.creationDate);
        dups.add(a);
      } else {
        noDups.add(a);
      }
    }
    return TwoLists<ArticleLines>(dups: dups, noDups: noDups);
  }
}
