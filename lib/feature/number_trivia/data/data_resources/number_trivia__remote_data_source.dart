import 'dart:convert';

import 'package:clean_architecture/feature/number_trivia/data/model/number_trivia_model.dart';
import 'package:clean_architecture/feature/weather/data/exception.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
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

class NumberTriviaRemoteDatasourceImpl implements NumberTriviaRemoteDataSource{
  final http.Client client ;

  NumberTriviaRemoteDatasourceImpl({required this.client});

  Future<NumberTriviaModel> _getTriviaFromUrl(String url) async {
    final response = await  client.get(Uri.parse(url),headers: {
      'Content-Type':'application/json',
    });
    if(response.statusCode == 200){
      return NumberTriviaModel.fromJson(json.decode(response.body));}
    else{
      throw ServerException();
    }
  }
  @override
  Future<NumberTriviaModel>? getConcreteNumberTrivia(int number) {
    return _getTriviaFromUrl('http://numbersapi.com/$number');
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    return _getTriviaFromUrl('http://numbersapi.com/random');
  }



}