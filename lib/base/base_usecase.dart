import 'dart:async';

import 'package:dio/dio.dart';

import 'package:homemakers_merchant/base/base_repo.dart';

class AddUseCase<I, Repo extends BaseCRUDRepo<I>> extends UseCaseIO<I, int> {
  AddUseCase(this.repo);
  final Repo repo;

  @override
  Future<int> call(I input) {
    return repo.add(input);
  }
}

class AddAllUseCase<I, Repo extends BaseCRUDRepo<I>> extends UseCaseIO<List<I>, List<int>> {
  AddAllUseCase(this.repo);
  final Repo repo;

  @override
  Future<List<int>> call(List<I> input) {
    return repo.addAll(input);
  }
}

class GetByIdUseCase<O, Repo extends BaseCRUDRepo<O>> extends UseCaseIO<int, O?> {
  GetByIdUseCase(this.repo);
  final Repo repo;

  @override
  Future<O?> call(int input) {
    return repo.getById(input);
  }
}

class GetAllUseCase<O, Repo extends BaseCRUDRepo<O>> extends UseCase<List<O>> {
  GetAllUseCase(this.repo);
  final Repo repo;

  @override
  Future<List<O>> call() {
    return repo.getAll();
  }
}

class UpdateUseCase<I, Repo extends BaseCRUDRepo<I>> extends UseCaseIO<I, void> {
  UpdateUseCase(this.repo);
  final Repo repo;

  @override
  Future<void> call(I input) {
    return repo.update(input);
  }
}

class UpdateAllUseCase<I, Repo extends BaseCRUDRepo<I>> extends UseCaseIO<List<I>, void> {
  UpdateAllUseCase(this.repo);
  final Repo repo;

  @override
  Future<void> call(List<I> input) {
    return repo.updateAll(input);
  }
}

class DeleteUseCase<I, Repo extends BaseCRUDRepo<I>> extends UseCaseIO<I, void> {
  DeleteUseCase(this.repo);
  final Repo repo;

  @override
  Future<void> call(I input) {
    return repo.delete(input);
  }
}

class DeleteAllUseCase<I, Repo extends BaseCRUDRepo<I>> extends UseCaseIO<List<I>, void> {
  DeleteAllUseCase(this.repo);
  final Repo repo;

  @override
  Future<void> call(List<I> input) {
    return repo.deleteAll(input);
  }
}

class ClearUseCase<Repo extends BaseCRUDRepo> extends UseCase<void> {
  ClearUseCase(this.repo);
  final Repo repo;

  @override
  Future<void> call() {
    return repo.clear();
  }
}

class GetUseCase<I, Repo extends BaseCRUDRepo<I>> extends UseCaseIO<I, void> {
  GetUseCase(this.repo);
  final Repo repo;

  @override
  Future<void> call(I input) {
    return repo.get(input);
  }
}

abstract class UseCase<T> {
  Future<T> call();
}

abstract class UseCaseIO<Input, T> {
  Future<T> call(Input input);
}

abstract class UseCaseIOPattern<Input, T> {
  Future<T> call((Input input,) record);
}

abstract class QueryAllUseCaseIORecord<PageKey, PageSize, SearchTerm, T> {
  Future<T> call((PageKey pageKey, PageSize pageSize, SearchTerm? searchText) record);
}

abstract class OrderQueryAllUseCaseIORecord<Type, PageKey, PageSize, SearchTerm, Filtering, Sorting, StartTime, EndTime, T> {
  Future<T> call(
      (
        PageKey pageKey,
        PageSize pageSize,
        SearchTerm? searchText,
        Type orderType,
        Filtering filtering,
        Sorting sorting,
        StartTime? startTime,
        EndTime? endTime,
      ) record);
}

abstract class UseCaseOptionalIO<Input, T> {
  Future<T?> call({Input? input});
}

abstract class UseCaseByID<Input1, Input2, T> {
  Future<T> call({required int id, Input1? input});
}

abstract class UseCaseByIDAndEntity<Input1, Input2, R> {
  Future<R> call({required Input1 input, required Input2 id});
}

abstract class BindingUseCase<Input1, Input2, T> {
  Future<T> call({required Input1 source, required Input2 destination});
}
