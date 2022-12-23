import 'package:mobx/mobx.dart';
import 'package:models_base/base.dart' show LineArticleAbstract;

extension ProductsSorted<A extends LineArticleAbstract> on ObservableList<A> {
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
