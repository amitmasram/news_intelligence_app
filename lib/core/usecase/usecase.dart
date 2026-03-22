import 'package:dartz/dartz.dart';
import 'package:news_intelligence_app/core/error/failures.dart';

abstract class UseCase<Output, Params> {
  Future<Either<Failure, Output>> call(Params params);
}

class NoParams {}
