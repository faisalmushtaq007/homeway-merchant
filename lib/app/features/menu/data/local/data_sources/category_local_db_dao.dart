part of 'package:homemakers_merchant/app/features/menu/index.dart';

class CategoryLocalDbRepository<Extras extends Category> implements BaseCategoryLocalDbRepository<Category> {
  // Completer is used for transforming synchronous code into asynchronous code.
  Future<Database> get _db async => AppDatabase.instance.database;

  StoreRef<int, Map<String, dynamic>> get _category => AppDatabase.instance.category;

  Function unOrdDeepEq = const DeepCollectionEquality.unordered().equals;

  @override
  Future<Either<RepositoryBaseFailure, Category>> add(Category entity) async {
    final result = await tryCatch<Category>(() async {
      final int recordID = await _category.add(await _db, entity.toMap());
      //final Category recordCategory = entity.copyWith(storeID: recordID.toString());
      await update(entity.copyWith(categoryId: recordID.toString()), UniqueId(recordID));
      final value = await _category.record(recordID).get(await _db);
      if (value != null) {
        final categoryEntity = Category.fromMap(value);
        final category = categoryEntity.copyWith(categoryId: recordID.toString());
        return category;
      } else {
        final category = entity.copyWith(categoryId: recordID.toString());
        return category;
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> delete(Category entity) async {
    final result = await tryCatch<bool>(() async {
      final int key = int.parse(entity.categoryId);
      final finder = Finder(filter: Filter.byKey(key));
      await _category.delete(
        await _db,
        finder: finder,
      );
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
        await _category.delete(transaction);
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
      final value = await _category.record(uniqueId.value).get(await _db);
      if (value != null) {
        await _category.delete(
          await _db,
        );
        return true;
      }
      return false;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, List<Category>>> getAll() async {
    final result = await tryCatch<List<Category>>(() async {
      final snapshots = await _category.find(await _db);
      if (snapshots.isEmptyOrNull) {
        return <Category>[];
      } else {
        return snapshots
            .map((snapshot) => Category.fromMap(snapshot.value).copyWith(
                  categoryId: snapshot.key.toString(),
                ))
            .toList();
      }
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, Category?>> getById(UniqueId id) async {
    final result = await tryCatch<Category?>(() async {
      final value = await _category.record(id.value).get(await _db);
      if (value != null) {
        return Category.fromMap(value);
      }
      return null;
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, Category>> update(Category entity, UniqueId uniqueId) async {
    final result = await tryCatch<Category>(() async {
      final int key = uniqueId.value;
      final value = await _category.record(key).get(await _db);
      if (value != null) {
        final result = await _category.record(key).update(
              await _db,
              entity.toMap(),
            );
        if (result != null) {
          return Category.fromMap(result);
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
  Future<Either<RepositoryBaseFailure, Category>> upsert(
      {UniqueId? id, String? token, required Category entity, bool checkIfUserLoggedIn = false}) async {
    final result = await tryCatch<Category>(() async {
      final int key = int.parse(entity.categoryId);
      final value = await _category.record(key).get(await _db);
      final result = await _category.record(key).put(await _db, entity.toMap(), merge: (value != null) || false);
      return Category.fromMap(result);
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteByIdAndEntity(UniqueId uniqueId, Category entity) {
    // TODO(prasant): implement deleteByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, Category>> getByIdAndEntity(UniqueId uniqueId, Category entity) {
    // TODO(prasant): implement getByIdAndEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, Category>> updateByIdAndEntity(UniqueId uniqueId, Category entity) {
    // TODO(prasant): implement updateByIdAndEntity
    throw UnimplementedError();
  }

  Future<Map<String, RecordSnapshot<int, Map<String, Object?>>>> getCategoryByIds(
      DatabaseClient db, List<int> ids) async {
    var snapshots = await _category.find(db,
        finder: Finder(filter: Filter.or(ids.map((e) => Filter.equals('categoryId', e)).toList())));
    return <String, RecordSnapshot<int, Map<String, Object?>>>{
      for (var snapshot in snapshots) snapshot.value['categoryId']!.toString(): snapshot
    };
  }

  @override
  Future<Either<RepositoryBaseFailure, List<Category>>> saveAll(
      {required List<Category> entities, bool hasUpdateAll = false}) async {
    final result = await tryCatch<List<Category>>(() async {
      final db = await _db;

      final result = await getAll();
      return result.fold((l) {
        return <Category>[];
      }, (r) async {
        final allOrderList = r.toList();
        final newList = entities.toList();
        var convertOrderToMapObject = newList.map((e) => e.toMap()).toList();
        final bool equalityStatus = unOrdDeepEq(allOrderList.toSet().toList(), newList.toSet().toList());

        await db.transaction((transaction) async {
          var categoryIds = convertOrderToMapObject.map((map) => map['categoryId'] as int).toList();
          var map = await getCategoryByIds(db, categoryIds);
          // Watch for deleted item
          var keysToDelete = (await _category.findKeys(transaction)).toList();
          for (var order in convertOrderToMapObject) {
            var snapshot = map[order['categoryId'] as int];
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
                await _category.record(key).put(transaction, order);
              }
            } else {
              // Add missing product
              await _category.add(transaction, order);
            }
          }
          // Delete the one not present any more
          await _category.records(keysToDelete).delete(transaction);
        });

        final result = await getAll();
        if (result.isRight()) {
          return result.right.toList();
        } else {
          return <Category>[];
        }
      });
    });
    return result;
  }

  @override
  Future<Either<RepositoryBaseFailure, List<Category>>> getAllWithPagination(
      {int pageKey = 1,
      int pageSize = 10,
      String? searchText,
      Map<String, dynamic> extras = const <String, dynamic>{},
      String? filter,
      String? sorting,
      Timestamp? startTimeStamp,
      Timestamp? endTimeStamp}) async {
    final result = await tryCatch<List<Category>>(() async {
      final db = await _db;
      Category? mainCategory;
      Category? subCategory;
      if (extras.containsKey('category')) {
        mainCategory = extras['category'] as Category;
      }
      if (extras.containsKey('subCategory')) {
        subCategory = extras['subCategory'] as Category;
      }

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
            (startTimeStamp.isNotNull || endTimeStamp.isNotNull)) {
          var mainCategoryRegExp = RegExp('^${mainCategory?.title.toLowerCase() ?? ''}\$', caseSensitive: false);
          var subCategoryRegExp = RegExp('^${subCategory?.title.toLowerCase() ?? ''}\$', caseSensitive: false);
          var regExp = RegExp('^${searchText ?? ''}\$', caseSensitive: false);
          var filterRegExp = RegExp('^${filter ?? ''}\$', caseSensitive: false);
          var sortingRegExp = RegExp('^${sorting ?? ''}\$', caseSensitive: false);
          finder = Finder(
            limit: pageSize,
            offset: pageKey,
            filter: Filter.and(
              [
                Filter.or([
                  Filter.matches('title', '^${searchText}'),
                  Filter.matches('title', '${searchText}\$'),
                  Filter.matches('title', '${searchText}'),
                  Filter.matchesRegExp(
                    'title',
                    mainCategoryRegExp,
                  ),
                  Filter.matches('subCategory.@.title', '^${searchText}'),
                  Filter.matches('subCategory.@.title', '${searchText}\$'),
                  Filter.matches('subCategory.@.title', '${searchText}'),
                  Filter.matchesRegExp(
                    'subCategory.@.title',
                    subCategoryRegExp,
                  ),
                  Filter.matchesRegExp(
                    'title',
                    regExp,
                  ),
                  Filter.matchesRegExp(
                    'subCategory.@.title',
                    regExp,
                  ),
                  Filter.matchesRegExp(
                    'title',
                    filterRegExp,
                  ),
                  Filter.matchesRegExp(
                    'subCategory.@.title',
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
          if (searchText!.isEmpty) {
            finder = Finder(
              limit: pageSize,
              offset: pageKey,
            );
          } else {
            var mainCategoryRegExp = RegExp('^${mainCategory?.title.toLowerCase() ?? ''}\$', caseSensitive: false);
            var subCategoryRegExp = RegExp('^${subCategory?.title.toLowerCase() ?? ''}\$', caseSensitive: false);
            var regExp = RegExp('^${searchText ?? ''}\$', caseSensitive: false);
            var filterRegExp = RegExp('^${filter ?? ''}\$', caseSensitive: false);
            var sortingRegExp = RegExp('^${sorting ?? ''}\$', caseSensitive: false);
            finder = Finder(
              /*sortOrders: [
          SortOrder('orderDateTime'),
        ],*/
              limit: pageSize,
              offset: pageKey,
              filter:Filter.and(
                [
                  Filter.or([
                    Filter.matchesRegExp(
                      'title',
                      mainCategoryRegExp,
                    ),
                    Filter.matchesRegExp(
                      'subCategory.@.title',
                      subCategoryRegExp,
                    ),
                    Filter.matchesRegExp(
                      'title',
                      regExp,
                    ),
                    Filter.matchesRegExp(
                      'subCategory.@.title',
                      regExp,
                    ),
                    Filter.matchesRegExp(
                      'title',
                      filterRegExp,
                    ),
                    Filter.matchesRegExp(
                      'subCategory.@.title',
                      filterRegExp,
                    ),
                  ]),
                ],
              ),
            );
          }
        }
        // Else
        else {
          finder = Finder(
            limit: pageSize,
            offset: pageKey,
          );
        }
        final recordSnapshots = await _category.find(
          await _db,
          finder: finder,
        );
        // Making a List<Category> out of List<RecordSnapshot>
        return recordSnapshots.map((snapshot) {
          final orders = Category.fromMap(snapshot.value).copyWith(
            // An ID is a key of a record from the database.
            categoryId: snapshot.key.toString(),
          );
          return orders;
        }).toList();
      });
    });
    return result;
  }
}
