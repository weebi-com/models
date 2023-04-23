import 'package:models_weebi/utils.dart';
import 'package:models_weebi/weebi_models.dart';

extension FindDups on List<ArticleLines> {
  TwoLists<ArticleLines> findDupsInNewList(
      {required List<ArticleLines> oldList}) {
    final noDups = <ArticleLines>[];
    final dups = <ArticleLines>[];
    if (oldList.length < length) {
      Map<int, ArticleLines> mapOldTitles = {};
      for (var p in oldList) {
        mapOldTitles[p.titleHash] = p;
      }
      for (var a in this) {
        if (mapOldTitles.keys.contains(a.titleHash)) {
          dups.add(a);
        } else {
          noDups.add(a);
        }
      }
      return TwoLists<ArticleLines>(listDups: dups, listNoDups: noDups);
    } else {
      // if oldList is longer, iterate over it brings better performance if
      Map<int, ArticleLines> mapNewTitles = {};
      for (var p in this) {
        mapNewTitles[p.titleHash] = p;
      }
      for (var a in oldList) {
        if (mapNewTitles.keys.contains(a.titleHash)) {
          dups.add(a);
        } else {
          noDups.add(a);
        }
      }
      return TwoLists<ArticleLines>(listDups: dups, listNoDups: noDups);
    }
  }
}
