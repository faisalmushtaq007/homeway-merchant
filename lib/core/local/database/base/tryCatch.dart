import 'package:homemakers_merchant/core/local/database/base/repository_failure.dart';
import 'package:homemakers_merchant/utils/functional/functional.dart';

Future<Either<RepositoryBaseFailure, E>> tryCatch<E>(Function f) async {
  try {
    //final result = await f.call();
    return Right(await f.call());
  } catch (e, st) {
    return Left(RepositoryFailure.localdb(
      e.toString(),
      stacktrace: st,
    ));
  }
}
