import 'package:mobx/mobx.dart';
import 'package:models_weebi/base.dart' show HerderAbstract;

extension HerdersSorted<H extends HerderAbstract> on ObservableList<H> {
  ObservableList<H> sortedByBidon() {
    return ObservableList.of(
      this..sort((a, b) => a.bidon.compareTo(b.bidon)),
    );
  }

  ObservableList<H> sortedByFirstName() {
    return ObservableList.of(
      this..sort((a, b) => a.firstName.compareTo(b.firstName)),
    );
  }

  ObservableList<H> sortedByLastName() {
    return ObservableList.of(
      this..sort((a, b) => a.lastName.compareTo(b.lastName)),
    );
  }

  ObservableList<H> sortedById() {
    return ObservableList.of(
      this..sort((a, b) => a.id.compareTo(b.id)),
    );
  }
}
