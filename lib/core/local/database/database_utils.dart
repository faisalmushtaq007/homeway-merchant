import 'package:sembast/sembast.dart';
import 'package:collection/collection.dart';

/// Filter record that contains the same field (i.e. check multiple fields value)
/// combine filters
Filter containsMapCombineFilter(Map<String, Object?> map) {
  return Filter.and(
      map.entries.map((e) => Filter.equals(e.key, e.value)).toList());
}

//var snapshots = await store.find(db,finder: Finder(filter: containsMapCombineFilter({'name': 'Daredevil', 'season': 1, 'episode': 13})));
//custom filter:
/// Filter record that contains the same field (i.e. check multiple fields value)
Filter containsMapCustomFilter(Map<String, Object?> map) {
  return Filter.custom((record) {
    var data = record.value as Map;
    for (var entry in map.entries) {
      if (data[entry.key] != entry.value) {
        return false;
      }
    }
    return true;
  });
}

//var snapshots = await store.find(db,finder: Finder(filter: containsMapCustomFilter({'name': 'Daredevil', 'season': 1, 'episode': 13})));

/// Filter record that contains the same field (i.e. check multiple fields value)
Filter mapEqualsFilter(Map<String, Object?> map) {
  return Filter.custom((record) {
    var data = record.value as Map;
    return DeepCollectionEquality().equals(map, data);
  });
}

//var snapshots = await store.find(db,finder: Finder(filter: mapEqualsFilter({'name': 'Daredevil', 'season': 1, 'episode': 13})));
