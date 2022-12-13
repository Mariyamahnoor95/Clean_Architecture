import 'dart:convert';

import 'package:clean_architecture/feature/weather/data/models/weather_model.dart';
import 'package:clean_architecture/feature/weather/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/json_reader.dart';

void main(){
  const tWeatherModel = WeatherModel(
    cityName: 'Jakarta',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const tWeather = Weather(
    cityName: 'Jakarta',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );
  
  group('to entity', () {
    test( 'should be a subclass of weather entity' , ()async {
      // assert
      final result = tWeatherModel.toEntity();
      expect(result, equals(tWeather));});
  });

  group('from json', () {
    test('should return a valid model from json', () async {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(
        readJson('/feature/weather/helpers/dummy_data/dummy_weather_response.json'),
      );

      // act
      final result = WeatherModel.fromJson(jsonMap);
      // assert
      expect(result, equals(tWeatherModel));
    });
  });
}