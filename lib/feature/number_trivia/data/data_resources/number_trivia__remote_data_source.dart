import 'package:clean_architecture/feature/number_trivia/data/model/number_trivia_model.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/number_trivia.dart';

abstract class NumberTriviaRemoteDataSource{
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future< NumberTriviaModel>? getConcreteNumberTrivia(int number);
  // Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future< NumberTriviaModel> getRandomNumberTrivia();
}