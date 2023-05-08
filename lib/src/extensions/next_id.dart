import 'package:mobx/mobx.dart';
import 'package:models_base/base.dart';
import 'package:models_weebi/src/models/article_line.dart';

extension NextLineArticleId on ObservableList<ArticleLine> {
  int get nextId {
    if (isEmpty) {
      return 1;
    } else {
      final that = this
        ..sort((a, b) => a.id.compareTo(b.id))
        ..toList();
      if (that.last.id < 0) {
        return 1;
      } else {
        return that.last.id + 1;
      }
    }
  }
}

extension NextArticleId<A extends ArticleAbstract> on Iterable<A> {
  int get nextId {
    if (isEmpty) {
      return 1;
    } else {
      final that = toList()
        ..sort((a, b) => a.id.compareTo(b.id))
        ..toList();
      if (that.last.id < 0) {
        return 1;
      } else {
        return that.last.id + 1;
      }
    }
  }
}

extension NextHerderId<H extends HerderAbstract> on Iterable<H> {
  int get nextId {
    if (isEmpty) {
      return 1;
    } else {
      final that = toList()
        ..sort((a, b) => a.id.compareTo(b.id))
        ..toList();
      if (that.last.id < 0) {
        return 1;
      } else {
        return that.last.id + 1;
      }
    }
  }
}

extension NextShopId<S extends ShopAbstract> on Iterable<S> {
  int get nextId {
    if (isEmpty) {
      return 1;
    } else {
      final that = toList()
        ..sort((a, b) => a.id.compareTo(b.id))
        ..toList();
      if (that.last.id < 0) {
        return 1;
      } else {
        return that.last.id + 1;
      }
    }
  }
}

extension NextTicketId<T extends TicketAbstract> on ObservableSet<T> {
  int get nextId {
    if (isEmpty) {
      return 1;
    } else {
      final that = toList()
        ..sort((a, b) => a.id.compareTo(b.id))
        ..toList();
      if (that.last.id < 0) {
        return 1;
      } else {
        return that.last.id + 1;
      }
    }
  }
}
