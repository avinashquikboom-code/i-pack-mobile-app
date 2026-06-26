import 'package:dartz/dartz.dart';
import 'package:i_pack_mobile_app/core/failures/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {
  const NoParams();
}
