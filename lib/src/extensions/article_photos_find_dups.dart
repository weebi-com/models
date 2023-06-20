import 'package:models_weebi/utils.dart';
import 'package:models_weebi/weebi_models.dart';

extension FindDupsArticlePhotos on List<ArticlePhoto> {
  TwoLists<ArticlePhoto> findDupsPhotosById(
      {required List<ArticlePhoto> newList}) {
    final noDups = <ArticlePhoto>[];
    final dups = <ArticlePhoto>[];
    if (isEmpty) {
      noDups.addAll(newList);
      return TwoLists<ArticlePhoto>(dups: dups, noDups: noDups);
    }
    for (final newItem in newList) {
      if (any((e) => e.calibreId == newItem.calibreId && e.id == newItem.id)) {
        dups.add(newItem);
      } else {
        noDups.add(newItem);
      }
    }
    return TwoLists(noDups: noDups, dups: dups);
  }
}
