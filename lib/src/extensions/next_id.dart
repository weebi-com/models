import 'package:mobx/mobx.dart';
import 'package:models_base/base.dart';

//TODO this is a bit silly to implement this for each model
// instead consider having a folding function for each object and apply nextId to that one only
extension NextLineArticleId<L extends ArticleLineAbstract> on Iterable<L> {
  int get nextId {
    if (isEmpty) {
      return 1;
    } else {
      toList().sort((a, b) => a.id.compareTo(b.id));
      if (last.id < 0) {
        return 1;
      } else {
        return last.id + 1;
      }
    }
  }
}

extension NextArticleId<A extends ArticleAbstract> on Iterable<A> {
  int get nextId {
    if (isEmpty) {
      return 1;
    } else {
      toList().sort((a, b) => a.id.compareTo(b.id));
      return last.id + 1;
    }
  }
}

extension NextHerderId<H extends HerderAbstract> on Iterable<H> {
  int get nextId {
    if (isEmpty) {
      return 1;
    } else {
      toList().sort((a, b) => a.id.compareTo(b.id));
      return last.id + 1;
    }
  }
}

extension NextShopId<S extends ShopAbstract> on Iterable<S> {
  int get nextId {
    if (isEmpty) {
      return 1;
    } else {
      toList().sort((a, b) => a.id.compareTo(b.id));
      return last.id + 1;
    }
  }
}

extension NextTicketId<T extends TicketAbstract> on ObservableSet<T> {
  int get nextId {
    if (isEmpty) {
      return 1;
    } else {
      final d = toList();
      d.sort((a, b) => a.id.compareTo(b.id));
      return d.last.id + 1;
    }
  }
}
