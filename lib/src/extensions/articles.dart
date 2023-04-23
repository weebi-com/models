import 'package:mobx/mobx.dart';
import 'package:models_base/base.dart' show ArticleLineAbstract;

extension ProductsSorted<A extends ArticleLineAbstract> on ObservableList<A> {
  ObservableList<A> sortedByTitle() {
    return ObservableList.of(
      this..sort((a, b) => a.title.compareTo(b.title)),
    );
  }

  ObservableList<A> sortedById() {
    return ObservableList.of(
      this..sort((a, b) => a.id.compareTo(b.id)),
    );
  }
}
