import 'package:models_weebi/src/models/herder.dart';

extension HerdersFinder<H extends Herder> on Iterable<H> {
  Set<int> findHerdersIdsWithFirstNameOrLastNameOrTel(String queryString) {
    final idsFirstName = findHerdersWithFirstName(queryString);
    final idsLastName = findHerdersWithLastName(queryString);
    final idsTel = findHerdersWithTel(queryString);

    final fullSetOfIds = Set.of(<int>{});
    for (final id in idsFirstName) {
      fullSetOfIds.add(id);
    }
    for (final id in idsLastName) {
      fullSetOfIds.add(id);
    }
    for (final id in idsTel) {
      fullSetOfIds.add(id);
    }
    return fullSetOfIds;
  }

  Set<int> findHerdersWithFirstName(String queryString) {
    final herdersMatch = where((c) => c.id != 0)
        .where((c) => c.firstName
            .trim()
            .toLowerCase()
            .contains(queryString.toLowerCase().trim()))
        .toList();
    final herdersMatchIds = Set.of(<int>{});
    for (final herder in herdersMatch) {
      herdersMatchIds.add(herder.id);
    }
    return herdersMatchIds;
  }

  Set<int> findHerdersWithLastName(String queryString) {
    final herdersMatch = where((c) => c.id != 0)
        .where((c) => c.lastName
            .trim()
            .toLowerCase()
            .contains(queryString.toLowerCase().trim()))
        .toList();
    final herdersMatchIds = Set.of(<int>{});
    for (final herder in herdersMatch) {
      herdersMatchIds.add(herder.id);
    }
    return herdersMatchIds;
  }

  Set<int> findHerdersWithTel(String queryString) {
    final herdersMatch = where((c) => c.id != 0)
        .where((c) => c.tel.trim().contains(queryString.trim()))
        .toList();
    final herdersMatchIds = Set.of(<int>{});
    for (final herder in herdersMatch) {
      herdersMatchIds.add(herder.id);
    }
    return herdersMatchIds;
  }

  Set<H> idsToHerders(Set<int> ids) {
    final _herders = Set.of(<H>{});
    for (final herder in this) {
      if (ids.contains(herder.id)) {
        _herders.add(herder);
      }
    }
    return _herders;
  }
}
