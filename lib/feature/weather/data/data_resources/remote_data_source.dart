import 'dart:convert';

import '../constants.dart';
import '../exception.dart';
import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource{
  Future<WeatherModel> getCurrentWeather(String cityName);
}
class RemoteDataSourceImpl implements RemoteDataSource{
  final http.Client client;
  RemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
 final response =
 await client.get(Uri.parse(Urls.currentWeatherByName(cityName)));
 if(response.statusCode == 200){
   return WeatherModel.fromJson(jsonDecode(response.body));}
 else{
   throw ServerException();
 }
  }
  }
