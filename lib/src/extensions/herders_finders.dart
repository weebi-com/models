import 'package:models_weebi/extensions.dart';
import 'package:models_weebi/src/models/herder.dart';

extension HerdersFinder<H extends Herder> on Iterable<H> {
  Iterable<H> get all => where((c) => c.id != 0);

  Set<int> findHerdersIdsWithNameOrTel(String queryString) {
    final idsFullName = findHerdersWithFullName(queryString);
    final idsFirstName = findHerdersWithFirstName(queryString);
    final idsLastName = findHerdersWithLastName(queryString);
    final idsTel = findHerdersWithTel(queryString);

    final fullSetOfIds = Set.of(<int>{});
    for (final id in idsFullName) {
      fullSetOfIds.add(id);
    }
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

  Set<int> findHerdersWithFullName(String queryString) {
    final herdersMatchIds = Set.of(<int>{});
    for (final e in concatFirstLastName.entries) {
      if (e.value.contains(queryString.clean)) {
        herdersMatchIds.add(e.key);
      }
    }
    return herdersMatchIds;
  }

  Set<int> findHerdersWithFirstName(String queryString) {
    final herdersMatch = all
        .where((c) => c.firstName.clean.contains(queryString.clean))
        .toList();
    final herdersMatchIds = Set.of(<int>{});
    for (final herder in herdersMatch) {
      herdersMatchIds.add(herder.id);
    }
    return herdersMatchIds;
  }

  Set<int> findHerdersWithLastName(String queryString) {
    final herdersMatch =
        all.where((c) => c.lastName.clean.contains(queryString.clean)).toList();
    final herdersMatchIds = Set.of(<int>{});
    for (final herder in herdersMatch) {
      herdersMatchIds.add(herder.id);
    }
    return herdersMatchIds;
  }

  Map<int, String> get concatFirstLastName {
    final herdersNames = <int, String>{};
    for (final herder in all) {
      final f = herder.firstName.clean;
      final l = herder.lastName.clean;
      herdersNames[herder.id] = f + ' ' + l;
    }
    return herdersNames;
  }

  Set<int> findHerdersWithTel(String queryString) {
    final herdersMatch =
        all.where((c) => c.tel.trim().contains(queryString.trim())).toList();
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
