/*
* Generic use case interface
* It is used to create use cases that can be used in any domain
* Uses T as the type of the object that will be returned by the use case
* Uses P as The type of the object that will be passed as a parameter to the use case
* Use cases returns Either<Failure, T> - Either a Failure or the object of type T
*/

import 'package:fire_hex_bloc/common/domain/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract class UseCase<T, P> {
  Future<Either<Failure, T>> call(P params);
}
