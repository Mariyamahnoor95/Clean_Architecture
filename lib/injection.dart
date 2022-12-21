import 'package:clean_architecture/feature/weather/data/data_resources/remote_data_source.dart';
import 'package:clean_architecture/feature/weather/data/repositories/weather_repository_impl.dart';
import 'package:clean_architecture/feature/weather/domain/repositories/weather_repository.dart';
import 'package:clean_architecture/feature/weather/presentation/bloc/weather_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'feature/weather/domain/usecases/get_current_weather.dart';

final locator = GetIt.instance;

void init(){
  //bloc
  locator.registerFactory(() => WeatherBloc(locator()));
  //usecase
  locator.registerLazySingleton(() => GetCurrentWeather(locator()));

  //repository
  locator.registerLazySingleton<WeatherRepository>(
          () => WeatherRepositoryImpl(remoteDataSource: locator(),));

  //datasource
  locator.registerLazySingleton<RemoteDataSource>(
          () => RemoteDataSourceImpl(client:locator(),));

  //external
  locator.registerLazySingleton(() => http.Client());
}