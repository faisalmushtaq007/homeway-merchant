import 'package:homemakers_merchant/utils/functional/functional.dart';
import './base/repository_failure.dart';

import './base/repository.dart';
import './base/identifiable.dart';

typedef Endo<T> = void Function(T);

class InMemoryRepository<E extends WithId> implements Repository<E> {
  static const void unit = null;

  Map<String, E> _entitySet;

  final Duration delay;

  factory InMemoryRepository.fromList(List<E> entities, {Duration delay = const Duration(milliseconds: 300)}) {
    final map = Map<String, E>.fromEntries(entities.map((e) => MapEntry(e.stringedId, e)));
    return InMemoryRepository._(map, delay);
  }

  factory InMemoryRepository.blank({Duration delay = const Duration(milliseconds: 0)}) {
    return InMemoryRepository<E>._({}, delay);
  }

  InMemoryRepository._(this._entitySet, Duration delay, {this.operation = 'edit', this.wikiRole = 3}) : this.delay = delay ?? const Duration(seconds: 0);

  String? entityId(E entity) => entity.stringedId;

  @override
  Future<Either<RepositoryBaseFailure, E>> add(E entity) async {
    final id = entityId(entity);
    _entitySet[id] = entity;
    return Right(entity);
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> delete(E entity) async {
    _entitySet.removeWhere((key, value) => value == entity);
    return Right(true);
  }

  @override
  Future<Either<RepositoryBaseFailure, List<E>>> getAll() async {
    await Future.delayed(delay);
    final list = _entitySet.values.toList();
    return Right(list);
  }

  @override
  Future<Either<RepositoryBaseFailure, E?>> getById(UniqueId id) async {
    await Future.delayed(delay);
    final entity = _entitySet[id.value];
    if (entity == null) return Left(RepositoryFailure.server('Entity not found'));
    return Right(entity);
  }

  @override
  Future<Either<RepositoryBaseFailure, E>> update(E entity, UniqueId? uniqueId) async {
    final id = entityId(entity);
    _entitySet[id] = entity;
    return Right(entity);
  }

  @override
  Future<Either<RepositoryBaseFailure, void>> clear() async {
    _entitySet = {};
    return Left(null);
  }

  @override
  Future<Either<RepositoryBaseFailure, void>> init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  String? currentUserToken;

  @override
  Future<Either<RepositoryBaseFailure, String>> getCurrentUserTokenByID(UniqueId id) {
    // TODO: implement getCurrentUserTokenByID
    throw UnimplementedError();
  }

  @override
  int? currentUserId;

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteAll() {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteById(UniqueId uniqueId) {
    // TODO: implement deleteById
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, E>> findUserByTokenOrID({UniqueId? id, String? token}) {
    // TODO: implement findUserByTokenOrID
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryBaseFailure, E>> upsert({UniqueId? id, String? token, required E entity, bool checkIfUserLoggedIn = false}) {
    // TODO: implement addOrUpdateUser
    throw UnimplementedError();
  }

  @override
  bool authStatus = false;

  @override
  String operation;

  @override
  int? wikiRole;

  // @override
  // Future<Either<Failure, E>> edit(UniqueId id, operation) async {
  //   final entity = entitySet[id.value];
  //   if (entity == null)
  //     return Left(RepositoryFailure.cache('Entity not found'));

  //   final updated = operation(entity);
  //   return Right(updated);
  // }
}
