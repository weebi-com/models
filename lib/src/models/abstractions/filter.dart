abstract class IdAbstract {
  int id;
  IdAbstract(this.id);
}

class FilterById<T extends IdAbstract> {
  final int id;
  final Iterable<T> input;

  const FilterById(this.id, this.input);
  Iterable<T> get output {
    final list = <T>[];
    for (final e in input) {
      if (e.id == id) {
        list.add(e);
      }
    }
    return list;
  }
}
