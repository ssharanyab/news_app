import 'package:dartz/dartz.dart';

import 'failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
