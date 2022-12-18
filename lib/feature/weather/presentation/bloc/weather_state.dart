part of 'weather_bloc.dart';

@immutable
abstract class WeatherState  extends Equatable{

  @override
  List<Object?> get props => [];
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);

  @override
  List<Object?> get props => [message];
}

class WeatherHasData extends WeatherState {
  final Weather result;

  WeatherHasData(this.result);

  @override
  List<Object?> get props => [result];
}