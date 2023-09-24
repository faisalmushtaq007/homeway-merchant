import 'package:homemakers_merchant/core/local/database/base/identifiable.dart';
import 'package:homemakers_merchant/core/local/database/base/repository.dart';
import 'package:homemakers_merchant/core/local/database/base/repository_failure.dart';
import 'package:homemakers_merchant/utils/functional/functional.dart';

typedef GetByIdFunc<T> = Future<Either<RepositoryBaseFailure, T>> Function(
    UniqueId);

typedef GetAllFunc<T> = Future<Either<RepositoryBaseFailure, List<T>>>
    Function();

typedef UpdateFunc<T> = Future<Either<RepositoryBaseFailure, T>> Function(T,
    [UniqueId uniqueId]);
typedef AddFunc<T> = Future<Either<RepositoryBaseFailure, T>> Function(T);
typedef DeleteFunc<T> = Future<Either<RepositoryBaseFailure, bool>> Function(T);
typedef DeleteAllFunc<T> = Future<Either<RepositoryBaseFailure, bool>>
    Function();
typedef DeleteByIdFunc<T> = Future<Either<RepositoryBaseFailure, bool>>
    Function(UniqueId uniqueId);
typedef DeleteByIdAndEntityFunc<T> = Future<Either<RepositoryBaseFailure, bool>>
    Function(UniqueId uniqueId, T input);
typedef GetByIdAndEntityFunc<T> = Future<Either<RepositoryBaseFailure, bool>>
    Function(UniqueId uniqueId, T input);
typedef UdpateByIdAndEntityFunc<T> = Future<Either<RepositoryBaseFailure, bool>>
    Function(UniqueId uniqueId, T input);
typedef BindingSourceToDestinationFunc<T, R>
    = Future<Either<RepositoryBaseFailure, List<R>>> Function(
        List<T> source, List<R> destination);
typedef UnBindingSourceToDestinationFunc<T, R>
    = Future<Either<RepositoryBaseFailure, List<R>>> Function(
        List<T> source, List<R> destination);
typedef AddAllFunc<T> = Future<Either<RepositoryBaseFailure, List<T>>> Function(
    List<T> listOfNewData);
typedef UpdateAllFunc<T> = Future<Either<RepositoryBaseFailure, List<T>>>
    Function(List<T> listOfExistingData);
typedef BindingFunc<T, R> = Future<Either<RepositoryBaseFailure, R>> Function(
    T source, R destination);
typedef UnBindingFunc<T, R> = Future<Either<RepositoryBaseFailure, R>> Function(
    T source, R destination);

class GetByIdFunction<T> implements GetById<T> {
  GetByIdFunction(this.function);
  final GetByIdFunc<T> function;

  @override
  Future<Either<RepositoryBaseFailure, T?>> getById(UniqueId id) =>
      function(id);
}

class GetAllFunction<T> implements GetAll<T> {
  GetAllFunction(this.function);
  final GetAllFunc<T> function;

  @override
  Future<Either<RepositoryBaseFailure, List<T>>> getAll() => function();
}

class UpdateFunction<T> implements Update<T> {
  UpdateFunction(this.function);
  final UpdateFunc<T> function;

  @override
  Future<Either<RepositoryBaseFailure, T>> update(
          T entity, UniqueId uniqueId) =>
      function(entity, uniqueId);
}

class AddFunction<T> implements Add<T> {
  AddFunction(this.function);
  final AddFunc<T> function;

  @override
  Future<Either<RepositoryBaseFailure, T>> add(T entity) => function(entity);
}

class DeleteFunction<T> implements Delete<T> {
  DeleteFunction(this.function);
  final DeleteFunc function;

  @override
  Future<Either<RepositoryBaseFailure, bool>> delete(
    T entity,
  ) =>
      function(entity);
}

class DeleteAllFunction<T> implements DeleteAll<T> {
  DeleteAllFunction(this.function);
  final DeleteAllFunc function;

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteAll() => function();
}

class DeleteByIdFunction<T> implements DeleteById<T> {
  DeleteByIdFunction(this.function);
  final DeleteByIdFunc function;

  @override
  Future<Either<RepositoryBaseFailure, bool>> deleteById(
    UniqueId uniqueId,
  ) =>
      function(uniqueId);
}
