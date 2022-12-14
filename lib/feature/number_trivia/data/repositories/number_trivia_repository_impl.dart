import 'package:clean_architecture/core/error/exception.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/core/network/network_info.dart';
import 'package:clean_architecture/feature/number_trivia/data/data_resources/number_trivia__remote_data_source.dart';
import 'package:clean_architecture/feature/number_trivia/data/data_resources/number_trivia_local_data_source.dart';
import 'package:clean_architecture/feature/number_trivia/data/model/number_trivia_model.dart';
import 'package:clean_architecture/feature/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture/feature/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';

typedef _ConcreteOrRandomChooser = Future<NumberTriviaModel> Function();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failures, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number)!;
    });
  }

  @override
  Future<Either<Failures, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failures, NumberTrivia>> _getTrivia(
      _ConcreteOrRandomChooser getConcreteOrRandom) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia!);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}