import 'dart:convert';
import 'package:clean_architecture/feature/weather/data/constants.dart';
import 'package:clean_architecture/feature/weather/data/data_resources/remote_data_source.dart';
import 'package:clean_architecture/feature/weather/data/exception.dart';
import 'package:clean_architecture/feature/weather/data/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';



void main (){
  late MockHttpClient mockHttpClient;
  late RemoteDataSourceImpl dataSource;
  setUp(() {
    mockHttpClient = MockHttpClient();
  dataSource = RemoteDataSourceImpl(client : mockHttpClient);
  });

  group('get current weather', () {
    const  tCityName= 'jakarta';
    //convert read json (string json) to map json by jsondecode and fromjson convert mapjson to model
    final tWeatherModel =WeatherModel.fromJson(jsonDecode(
        readJson('/feature/weather/helpers/dummy_data/dummy_weather_response.json'))) ;


    test('should return weather model when the response code 200', () async {
      //arrange
      when(
          mockHttpClient.get(Uri.parse(Urls.currentWeatherByName(tCityName))),
      ).thenAnswer((_) async => http.Response(
          readJson('/feature/weather/helpers/dummy_data/dummy_weather_response.json'),200),
    );
      // act
      final result = await dataSource.getCurrentWeather(tCityName);

      // assert
      expect(result, equals(tWeatherModel));
  },);

    test('should return exception when  response code 404', () async {
      //arrange
      when(
        mockHttpClient.get(Uri.parse(Urls.currentWeatherByName(tCityName))),
      ).thenAnswer((_) async => http.Response(
          'Not found ',404),
      );
      // act
      final call =  dataSource.getCurrentWeather(tCityName);

      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    },);


}
);
}