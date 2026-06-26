import 'package:dartz/dartz.dart';
import 'package:i_pack_mobile_app/core/failures/failures.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class NoParams {
  const NoParams();
}
