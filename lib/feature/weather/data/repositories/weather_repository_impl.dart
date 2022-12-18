import 'dart:io';

import 'package:clean_architecture/feature/weather/data/data_resources/remote_data_source.dart';
import 'package:clean_architecture/feature/weather/data/exception.dart';
import 'package:clean_architecture/feature/weather/data/failure.dart';
import 'package:clean_architecture/feature/weather/domain/entities/weather.dart';
import 'package:clean_architecture/feature/weather/domain/repositories/weather_repository.dart';
import 'package:dartz/dartz.dart';

class WeatherRepositoryImpl implements WeatherRepository{
  final RemoteDataSource remoteDataSource;

  WeatherRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName) async {
    try{
      final result= await remoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException{
      return left(const ServerFailure(''));
    }on SocketException {
      return left(const ConnectionFailure('Failed to connect to the network'));
    }
    }

  }

