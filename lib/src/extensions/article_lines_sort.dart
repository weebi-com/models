import 'package:mobx/mobx.dart';
import 'package:models_weebi/base.dart';

extension LinesSorted<P extends ArticleLineAbstract> on ObservableList<P> {
  ObservableList<P> sortedByTitle() {
    return ObservableList.of(
      this..sort((a, b) => a.title.compareTo(b.title)),
    );
  }

  ObservableList<P> sortedByTitleReversed() {
    return ObservableList.of(
      this..sort((a, b) => b.title.compareTo(a.title)),
    );
  }

  ObservableList<P> sortedById() {
    return ObservableList.of(
      this..sort((a, b) => a.id.compareTo(b.id)),
    );
  }

  ObservableList<P> sortedByIdReversed() {
    return ObservableList.of(
      this..sort((a, b) => b.id.compareTo(a.id)),
    );
  }
}
