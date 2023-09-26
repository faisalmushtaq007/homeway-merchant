part of 'package:homemakers_merchant/app/features/address/index.dart';

class AddressLocalDbRepository<T extends AddressModel> implements BaseAddressBankLocalDbRepository<AddressModel> {
  Future<Database> get _db async => AppDatabase.instance.database;

  StoreRef<int, Map<String, dynamic>> get _address => AppDatabase.instance.address;

  @override
  Future<Either<RepositoryBaseFailure, AddressModel>> add(AddressModel entity) async {
    final result = await tryCatch<AddressModel>(() async {
      final int recordID = await _address.add(await _db, entity.toMap());
      //final AddressModel recordAddressModel = entity.copyWith(storeID: recordID.toString());
      await update(entity.copyWith(addressID: recordID), UniqueId(recordID));
      final value = await _address.record(recordID).get(await _db);
      if (value != null) {
        final storedAddressModel = AddressModel.fromJson(value);
        final storeEntity = storedAddressModel.copyWith(addressID: recordID);
        return storeEntity;
      } else {
        final storeEntity = entity.copyWith(addressID: recordID);
        return storeEntity;
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> delete(AddressModel entity) async {
    final result = await tryCatch<bool>(() async {
      final int key = entity.addressID;
      final finder = Finder(filter: Filter.byKey(key));
      final int count = await _address.delete(
        await _db,
        finder: finder,
      );
      if (count >= 0) {
        return true;
      } else {
        return false;
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteAll() async {
    final result = await tryCatch<bool>(() async {
      final db = await _db;
      int count = 0;
      await db.transaction((transaction) async {
        // Delete all
        await _address.delete(transaction);
        count++;
      });
      if (count >= 0) {
        return true;
      } else {
        return false;
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteById(UniqueId uniqueId) async {
    final result = await tryCatch<bool>(() async {
      final value = await _address.record(uniqueId.value).get(await _db);
      if (value != null) {
        await _address.delete(
          await _db,
        );
        return true;
      }
      return false;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteByIdAndEntity(UniqueId uniqueId, AddressModel entity) async {
    // TODO(prasant): implement deleteByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, List<AddressModel>>> getAll() async {
    final result = await tryCatch<List<AddressModel>>(() async {
      final snapshots = await _address.find(await _db);
      if (snapshots.isEmptyOrNull) {
        return <AddressModel>[];
      } else {
        return snapshots
            .map(
              (snapshot) => AddressModel.fromJson(snapshot.value).copyWith(
                addressID: snapshot.key,
              ),
            )
            .toList();
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, AddressModel?>> getById(UniqueId id) async {
    final result = await tryCatch<AddressModel?>(() async {
      final value = await _address.record(id.value).get(await _db);
      if (value != null) {
        return AddressModel.fromJson(value);
      }
      return null;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, AddressModel>> getByIdAndEntity(UniqueId uniqueId, AddressModel entity) async {
    // TODO(prasant): implement getByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, AddressModel>> update(AddressModel entity, UniqueId uniqueId) async {
    final result = await tryCatch<AddressModel>(() async {
      final int key = uniqueId.value;
      final value = await _address.record(key).get(await _db);
      if (value != null) {
        final result = await _address.record(key).update(
              await _db,
              entity.toMap(),
            );
        if (result != null) {
          return AddressModel.fromJson(result);
        } else {
          return upsert(id: uniqueId, entity: entity);
        }
      } else {
        return upsert(id: uniqueId, entity: entity);
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, AddressModel>> updateByIdAndEntity(
      UniqueId uniqueId, AddressModel entity) async {
    // TODO(prasant): implement updateByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, AddressModel>> upsert({
    required AddressModel entity,
    UniqueId? id,
    String? token,
    bool checkIfUserLoggedIn = false,
  }) async {
    final result = await tryCatch<AddressModel>(() async {
      final int key = entity.addressID;
      final value = await _address.record(key).get(await _db);
      final result = await _address.record(key).put(await _db, entity.toMap(), merge: (value != null) || false);
      return AddressModel.fromJson(result);
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, List<AddressModel>>> getAllWithPagination({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    Map<String, dynamic> extras = const <String, dynamic>{},
    String? filter,
    String? sorting,
    Timestamp? startTimeStamp,
    Timestamp? endTimeStamp,
  }) async {
    appLog.d('Address search ${searchText}');
    final result = await tryCatch<List<AddressModel>>(() async {
      final db = await _db;

      return await db.transaction((transaction) async {
        // Finder object can also sort data.
        Finder finder = Finder(
          limit: pageSize,
          offset: pageKey,
        );
        // If
        if ((searchText.isNotNull ||
            filter.isNotNull ||
            sorting.isNotNull && (searchText!.isNotEmpty || filter!.isNotEmpty || sorting!.isNotEmpty)) &&
            (startTimeStamp.isNotNull || endTimeStamp.isNotNull)){
          appLog.d('Address search1 ${searchText}');
          var regExp = RegExp('^${searchText ?? ''}\$', caseSensitive: false);
          var filterRegExp = RegExp('^${filter ?? ''}\$', caseSensitive: false);
          var sortingRegExp = RegExp('^${sorting ?? ''}\$', caseSensitive: false);
          finder = Finder(
            limit: pageSize,
            offset: pageKey,
            filter: Filter.and(
              [
                Filter.or([
                  Filter.matches('fullName', '^${searchText}'),
                  Filter.matches('fullName', '${searchText}\$'),
                  Filter.matches('fullName', '${searchText}'),
                  Filter.matches('address.apartment', '^${searchText}'),
                  Filter.matches('address.apartment', '${searchText}\$'),
                  Filter.matches('address.apartment', '${searchText}'),
                  Filter.matchesRegExp(
                    'address.apartment',
                    regExp,
                  ),
                  Filter.matches('address.landmark', '^${searchText}'),
                  Filter.matches('address.landmark', '${searchText}\$'),
                  Filter.matches('address.landmark', '${searchText}'),
                  Filter.matchesRegExp(
                    'address.landmark',
                    regExp,
                  ),
                  Filter.matches('address.postal_code', '^${searchText}'),
                  Filter.matches('address.postal_code', '${searchText}\$'),
                  Filter.matches('address.postal_code', '${searchText}'),
                  Filter.matchesRegExp(
                    'address.postal_code',
                    regExp,
                  ),
                  Filter.matches('address.displayAddressName', '^${searchText}'),
                  Filter.matches('address.displayAddressName', '${searchText}\$'),
                  Filter.matches('address.displayAddressName', '${searchText}'),
                  Filter.matchesRegExp(
                    'address.displayAddressName',
                    regExp,
                  ),
                  Filter.matches('address.village', '^${searchText}'),
                  Filter.matches('address.village', '${searchText}\$'),
                  Filter.matches('address.village', '${searchText}'),
                  Filter.matchesRegExp(
                    'address.village',
                    regExp,
                  ),
                  Filter.matches('address.town', '^${searchText}'),
                  Filter.matches('address.town', '${searchText}\$'),
                  Filter.matches('address.town', '${searchText}'),
                  Filter.matchesRegExp(
                    'address.town',
                    regExp,
                  ),
                  Filter.matches('address.saved_address_as', '^${searchText}'),
                  Filter.matches('address.saved_address_as', '${searchText}\$'),
                  Filter.matches('address.saved_address_as', '${searchText}'),
                  Filter.matchesRegExp(
                    'address.saved_address_as',
                    regExp,
                  ),
                  Filter.matches('address.municipality', '^${searchText}'),
                  Filter.matches('address.municipality', '${searchText}\$'),
                  Filter.matches('address.municipality', '${searchText}'),
                  Filter.matchesRegExp(
                    'address.municipality',
                    regExp,
                  ),
                  Filter.matches('address.city', '^${searchText}'),
                  Filter.matches('address.city', '${searchText}\$'),
                  Filter.matches('address.city', '${searchText}'),
                  Filter.matchesRegExp(
                    'address.city',
                    regExp,
                  ),
                  Filter.matches('address.state', '^${searchText}'),
                  Filter.matches('address.state', '${searchText}\$'),
                  Filter.matches('address.state', '${searchText}'),
                  Filter.matchesRegExp(
                    'address.state',
                    regExp,
                  ),
                  Filter.matches('address.country', '^${searchText}'),
                  Filter.matches('address.country', '${searchText}\$'),
                  Filter.matches('address.country', '${searchText}'),
                  Filter.matchesRegExp(
                    'address.country',
                    regExp,
                  ),
                  Filter.matches('address.district', '^${searchText}'),
                  Filter.matches('address.district', '${searchText}\$'),
                  Filter.matches('address.district', '${searchText}'),
                  Filter.matchesRegExp(
                    'address.district',
                    filterRegExp,
                  ),
                  Filter.matchesRegExp(
                    'address.state',
                    filterRegExp,
                  ),
                  Filter.matchesRegExp(
                    'address.country',
                    filterRegExp,
                  ),
                  Filter.matchesRegExp(
                    'address.postal_code',
                    filterRegExp,
                  ),
                ]),
              ],
            ),
          );
        }
        // Else If
        else if (searchText.isNotNull ||
            filter.isNotNull ||
            sorting.isNotNull && (searchText!.isNotEmpty || filter!.isNotEmpty || sorting!.isNotEmpty)) {
          appLog.d('Address search2 ${searchText}');
          if (searchText!.isEmpty) {
            appLog.d('Address search3 ${searchText}');
            finder = Finder(
              limit: pageSize,
              offset: pageKey,
            );
          } else {
            appLog.d('Address search4 ${searchText}');
            var regExp = RegExp('^${searchText ?? ''}\$', caseSensitive: false);
            var filterRegExp = RegExp('^${filter ?? ''}\$', caseSensitive: false);
            var sortingRegExp = RegExp('^${sorting ?? ''}\$', caseSensitive: false);
            finder = Finder(
              /*sortOrders: [
          SortOrder('orderDateTime'),
        ],*/
              limit: pageSize,
              offset: pageKey,
              filter: Filter.or([
                Filter.matches('fullName', '^${searchText}'),
                Filter.matches('fullName', '${searchText}\$'),
                Filter.matches('fullName', '${searchText}'),
                Filter.matches('address.apartment', '^${searchText}'),
                Filter.matches('address.apartment', '${searchText}\$'),
                Filter.matches('address.apartment', '${searchText}'),
                Filter.matchesRegExp(
                  'address.apartment',
                  regExp,
                ),
                Filter.matches('address.landmark', '^${searchText}'),
                Filter.matches('address.landmark', '${searchText}\$'),
                Filter.matches('address.landmark', '${searchText}'),
                Filter.matchesRegExp(
                  'address.landmark',
                  regExp,
                ),
                Filter.matches('address.postal_code', '^${searchText}'),
                Filter.matches('address.postal_code', '${searchText}\$'),
                Filter.matches('address.postal_code', '${searchText}'),
                Filter.matchesRegExp(
                  'address.postal_code',
                  regExp,
                ),
                Filter.matches('address.displayAddressName', '^${searchText}'),
                Filter.matches('address.displayAddressName', '${searchText}\$'),
                Filter.matches('address.displayAddressName', '${searchText}'),
                Filter.matchesRegExp(
                  'address.displayAddressName',
                  regExp,
                ),
                Filter.matches('address.village', '^${searchText}'),
                Filter.matches('address.village', '${searchText}\$'),
                Filter.matches('address.village', '${searchText}'),
                Filter.matchesRegExp(
                  'address.village',
                  regExp,
                ),
                Filter.matches('address.town', '^${searchText}'),
                Filter.matches('address.town', '${searchText}\$'),
                Filter.matches('address.town', '${searchText}'),
                Filter.matchesRegExp(
                  'address.town',
                  regExp,
                ),
                Filter.matches('address.saved_address_as', '^${searchText}'),
                Filter.matches('address.saved_address_as', '${searchText}\$'),
                Filter.matches('address.saved_address_as', '${searchText}'),
                Filter.matchesRegExp(
                  'address.saved_address_as',
                  regExp,
                ),
                Filter.matches('address.municipality', '^${searchText}'),
                Filter.matches('address.municipality', '${searchText}\$'),
                Filter.matches('address.municipality', '${searchText}'),
                Filter.matchesRegExp(
                  'address.municipality',
                  regExp,
                ),
                Filter.matches('address.city', '^${searchText}'),
                Filter.matches('address.city', '${searchText}\$'),
                Filter.matches('address.city', '${searchText}'),
                Filter.matchesRegExp(
                  'address.city',
                  regExp,
                ),
                Filter.matches('address.state', '^${searchText}'),
                Filter.matches('address.state', '${searchText}\$'),
                Filter.matches('address.state', '${searchText}'),
                Filter.matchesRegExp(
                  'address.state',
                  regExp,
                ),
                Filter.matches('address.country', '^${searchText}'),
                Filter.matches('address.country', '${searchText}\$'),
                Filter.matches('address.country', '${searchText}'),
                Filter.matchesRegExp(
                  'address.country',
                  regExp,
                ),
                Filter.matches('address.district', '^${searchText}'),
                Filter.matches('address.district', '${searchText}\$'),
                Filter.matches('address.district', '${searchText}'),
                Filter.matchesRegExp(
                  'address.district',
                  filterRegExp,
                ),
                Filter.matchesRegExp(
                  'address.state',
                  filterRegExp,
                ),
                Filter.matchesRegExp(
                  'address.country',
                  filterRegExp,
                ),
                Filter.matchesRegExp(
                  'address.postal_code',
                  filterRegExp,
                ),
              ]),
            );
          }
        }
        // Else
        else {
          appLog.d('Address search5 ${searchText}');
          finder = Finder(
            limit: pageSize,
            offset: pageKey,
          );
        }
        final recordSnapshots = await _address.find(
          await _db,
          finder: finder,
        );
        // Making a List<AddressModel> out of List<RecordSnapshot>
        return recordSnapshots.map((snapshot) {
          final orders = AddressModel.fromJson(snapshot.value).copyWith(
            // An ID is a key of a record from the database.
            addressID: snapshot.key,
          );
          return orders;
        }).toList();
      });
    });
    return result;
  }

  Future<Map<String, RecordSnapshot<int, Map<String, Object?>>>> getCategoryByIds(
      DatabaseClient db, List<int> ids) async {
    var snapshots = await _address.find(db,
        finder: Finder(filter: Filter.or(ids.map((e) => Filter.equals('addressID', e)).toList())));
    return <String, RecordSnapshot<int, Map<String, Object?>>>{
      for (var snapshot in snapshots) snapshot.value['addressID']!.toString(): snapshot
    };
  }

  @override
  Future<Either<RepositoryBaseFailure, List<AddressModel>>> saveAll(
      {required List<AddressModel> entities, bool hasUpdateAll = false}) async {
    final result = await tryCatch<List<AddressModel>>(() async {
      final db = await _db;

      final result = await getAll();
      return result.fold((l) {
        return <AddressModel>[];
      }, (r) async {
        final allOrderList = r.toList();
        final newList = entities.toList();
        var convertOrderToMapObject = newList.map((e) => e.toMap()).toList();
        final bool equalityStatus = unOrdDeepEq(allOrderList.toSet().toList(), newList.toSet().toList());

        await db.transaction((transaction) async {
          var addressIds = convertOrderToMapObject.map((map) => map['addressID'] as int).toList();
          var map = await getCategoryByIds(db, addressIds);
          // Watch for deleted item
          var keysToDelete = (await _address.findKeys(transaction)).toList();
          for (var order in convertOrderToMapObject) {
            var snapshot = map[order['addressID'] as int];
            if (snapshot != null) {
              // The record current key
              var key = snapshot.key;
              // Remove from deletion list
              keysToDelete.remove(key);
              // Don't update if no change
              if (const DeepCollectionEquality().equals(snapshot.value, order)) {
                // no changes
                continue;
              } else {
                // Update product
                await _address.record(key).put(transaction, order);
              }
            } else {
              // Add missing product
              await _address.add(transaction, order);
            }
          }
          // Delete the one not present any more
          await _address.records(keysToDelete).delete(transaction);
        });

        final result = await getAll();
        if (result.isRight()) {
          return result.right.toList();
        } else {
          return <AddressModel>[];
        }
      });
    });
    return result;
  }
}
