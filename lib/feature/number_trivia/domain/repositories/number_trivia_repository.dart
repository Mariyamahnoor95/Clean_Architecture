import 'package:clean_architecture/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/number_trivia.dart';
// repository contract
abstract class NumberTriviaRepository{
  Future<Either<Failures, NumberTrivia>>? getConcreteNumberTrivia(int number);
  Future<Either<Failures, NumberTrivia>>? getRandomNumberTrivia();

}