import 'package:homemakers_merchant/utils/functional/functional.dart';
import 'identifiable.dart';
import 'repository_failure.dart';
import 'repository.dart';

class GetByIdDecorator<T> implements GetById<T> {
  final GetById<T> repository;
  final void Function() function;

  GetByIdDecorator(this.repository, this.function);

  @override
  Future<Either<RepositoryBaseFailure, T?>> getById(UniqueId id) {
    function();
    return repository.getById(id);
  }
}
