
import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../entities/weather.dart';

//dependency inversion in solid principles
// abstract class repository which will define a contract which the repository must do
//means it is interface but dart doesnt support interface so it use abstract classes
abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName);
}
// now the implementation of this abstract class define in repository of  data layer

