import 'package:fpdart/fpdart.dart';
import 'package:social_networking/core/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
