import 'package:homemakers_merchant/core/local/database/base/repository_function.dart';
import 'package:homemakers_merchant/utils/functional/functional.dart';
import 'repository_operation.dart';
import 'repository.dart';
import './repository_failure.dart';
import './identifiable.dart';

class BaseRepositoryOperation<EntityType> {}

extension OperationValue<EntityType> on BaseRepositoryOperation<EntityType> {
  RepositoryOperation get operation {
    if (this is GetById<EntityType>) {
      return RepositoryOperation.getById;
    } else if (this is GetAll<EntityType>) {
      return RepositoryOperation.getAll;
    } else if (this is Add<EntityType>) {
      return RepositoryOperation.add;
    } else if (this is Update<EntityType>) {
      return RepositoryOperation.update;
    } else if (this is Delete<EntityType>) {
      return RepositoryOperation.delete;
    } else if (this is FindUserByTokenOrID<EntityType>) {
      return RepositoryOperation.findUserByTokenOrId;
    } else {
      return RepositoryOperation.edit;
    }
  }
}

abstract class Add<EntityType> extends BaseRepositoryOperation<EntityType> {
  /// Saves a new instance to repository
  ///
  /// The newly created entity might get modified by the repository
  /// e.g gets a new Id. But could also be null.
  Future<Either<RepositoryBaseFailure, EntityType>> add(EntityType entity);
}

abstract class GetAll<EntityType> extends BaseRepositoryOperation<EntityType> {
  /// Returns a list of all entities in repository
  ///
  /// Will return empty array if no entities found.
  Future<Either<RepositoryBaseFailure, List<EntityType>>> getAll();
}

abstract class Delete<EntityType> extends BaseRepositoryOperation<EntityType> {
  /// Completely remove the entity instance from repository
  Future<Either<RepositoryBaseFailure, bool>> delete(EntityType entity);
}

abstract class GetById<EntityType> extends BaseRepositoryOperation<EntityType> {
  /// Returns the object with the given a unique id
  ///
  /// Will return a Failure if no corresponding entity for id is found.
  Future<Either<RepositoryBaseFailure, EntityType?>> getById(UniqueId id);
}

abstract class Update<EntityType> extends BaseRepositoryOperation<EntityType> {
  /// Replaces an entity present in the repository by the provided one.
  ///
  /// Note: Concrete implementation will more likely constraints
  /// EntityType to be have an Id or be equatable.
  Future<Either<RepositoryBaseFailure, EntityType>> update(
    EntityType entity,
    UniqueId uniqueId,
  );
}

/// Edit provides partial updates of entities.
///
/// Edit is a more complex operation since in some cases it could be expressed as a function
/// and others like a Map<String, dynamic>.
/// Note: Edit is not part of the repository definition as this would imply
/// Extending all repositories to have 2 type variables.
abstract class Edit<Operation, EntityType> extends BaseRepositoryOperation<EntityType> {
  /// Performs some edit operation on a already present entity.
  Future<Either<RepositoryBaseFailure, EntityType>> edit(
    UniqueId id,
    Operation operation,
  );
}

/// A repository with only with the subset of opertions related to reading
///
/// Operations: GetAll and GetById
abstract class ReadOnlyRepository<EntityType> implements GetAll<EntityType>, GetById<EntityType> {}

abstract class WriteOnlyRepository<EntityType> implements Add<EntityType>, Delete<EntityType>, Update<EntityType> {}

abstract class Repository<EntityType>
    implements
        ReadOnlyRepository<EntityType>,
        WriteOnlyRepository<EntityType>,
        Init<EntityType>,
        GetCurrentUserTokenByID<EntityType>,
        DeleteAll<EntityType>,
        DeleteById<EntityType>,
        FindUserByTokenOrID<EntityType>,
        AddOrUpdateUser<EntityType> {
  late String? currentUserToken;
  late int? currentUserId;
  bool authStatus = false;
  Future<Either<RepositoryBaseFailure, void>> clear();
}

abstract class Init<EntityType> extends BaseRepositoryOperation<EntityType> {
  /// Completely remove the entity instance from repository
  Future<Either<RepositoryBaseFailure, void>> init();
}

abstract class GetCurrentUserTokenByID<EntityType> extends BaseRepositoryOperation<EntityType> {
  /// Returns the object with the given a unique id
  ///
  /// Will return a Failure if no corresponding entity for id is found.
  Future<Either<RepositoryBaseFailure, String>> getCurrentUserTokenByID(
    UniqueId id,
  );
}

abstract class DeleteAll<EntityType> extends BaseRepositoryOperation<EntityType> {
  /// Completely remove the entity instance from repository
  Future<Either<RepositoryBaseFailure, bool>> deleteAll();
}

abstract class DeleteById<EntityType> extends BaseRepositoryOperation<EntityType> {
  /// Completely remove the entity instance from repository
  Future<Either<RepositoryBaseFailure, bool>> deleteById(UniqueId uniqueId);
}

abstract class DeleteByIdAndEntity<EntityType> extends BaseRepositoryOperation<EntityType> {
  /// Completely remove the entity instance from repository
  Future<Either<RepositoryBaseFailure, bool>> deleteByIdAndEntity(UniqueId uniqueId, EntityType entity);
}

abstract class UpdateByIdAndEntity<EntityType> extends BaseRepositoryOperation<EntityType> {
  /// Completely update the entity instance from repository
  Future<Either<RepositoryBaseFailure, EntityType>> updateByIdAndEntity(UniqueId uniqueId, EntityType entity);
}

abstract class GetByIdAndEntity<EntityType> extends BaseRepositoryOperation<EntityType> {
  /// Completely get the entity instance from repository
  Future<Either<RepositoryBaseFailure, EntityType>> getByIdAndEntity(UniqueId uniqueId, EntityType entity);
}

abstract class FindUserByTokenOrID<EntityType> extends BaseRepositoryOperation<EntityType> {
  /// Returns the object with the given a unique id
  ///
  /// Will return a Failure if no corresponding entity for id is found.
  Future<Either<RepositoryBaseFailure, EntityType>> findUserByTokenOrID({
    UniqueId? id,
    String? token,
  });
}

abstract class AddOrUpdateUser<EntityType> extends BaseRepositoryOperation<EntityType> {
  /// Returns the object with the given a model
  ///
  /// Will return a Failure if no corresponding entity for id is found.
  Future<Either<RepositoryBaseFailure, EntityType>> upsert({
    UniqueId? id,
    String? token,
    required EntityType entity,
    bool checkIfUserLoggedIn = false,
  });
}

// Binding
abstract class BaseRepositoryBindOperation<T, R> {
  BindingSourceToDestinationFunc<T, R> binding(List<T> source, List<R> destination);
}

abstract class BindSourceToDestination<T, R> implements BaseRepositoryBindOperation<T, R> {
  @override
  BindingSourceToDestinationFunc<T, R> binding(List<T> source, List<R> destination);
}

// Add all
abstract class BaseRepositoryAddAllOperation<EntityType> {
  BaseRepositoryAddAllOperation<EntityType> addALL(EntityType entities);
}

abstract class AddAll<EntityType> implements BaseRepositoryAddAllOperation<EntityType> {
  @override
  BaseRepositoryAddAllOperation<EntityType> addALL(EntityType entities);
}

// Update all
abstract class BaseRepositoryUpdateAllOperation<EntityType> {
  BaseRepositoryUpdateAllOperation<EntityType> updateALL(EntityType entities);
}

abstract class UpdateAll<EntityType> implements BaseRepositoryUpdateAllOperation<EntityType> {
  @override
  BaseRepositoryUpdateAllOperation<EntityType> updateALL(EntityType entities);
}
