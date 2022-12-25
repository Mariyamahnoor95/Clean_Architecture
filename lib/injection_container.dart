import 'package:clean_architecture/core/network/network_info.dart';
import 'package:clean_architecture/core/presentation/utils/input_validation.dart';
import 'package:clean_architecture/feature/number_trivia/data/data_resources/number_trivia__remote_data_source.dart';
import 'package:clean_architecture/feature/number_trivia/data/data_resources/number_trivia_local_data_source.dart';
import 'package:clean_architecture/feature/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:clean_architecture/feature/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_architecture/feature/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_architecture/feature/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_architecture/feature/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;
Future<void> init() async {
  // Features - NumberTrivia
  //bloc
sl.registerFactory(
        () => NumberTriviaBloc(
    getConcreteNumberTrivia: sl(),
    getRandomNumberTrivia: sl(),
    inputConverter: sl())
);

//Use case
sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

// repository
sl.registerLazySingleton<NumberTriviaRepository>(() =>
    NumberTriviaRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl()));

//Data source
sl.registerLazySingleton<NumberTriviaRemoteDataSource>(() =>
    NumberTriviaRemoteDatasourceImpl(client: sl()));

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(() =>
      NumberTriviaLocalDataSourceImpl(sharedPreferences : sl()));

  // Core
sl.registerLazySingleton(() => InputConverter());
sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  
}
