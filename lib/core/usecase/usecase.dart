import 'package:chronicles/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Usecase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>>  call(Params params);
}