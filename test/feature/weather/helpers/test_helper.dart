import 'package:clean_architecture/feature/weather/data/data_resources/remote_data_source.dart';
import 'package:clean_architecture/feature/weather/domain/repositories/weather_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks(
  [
    WeatherRepository,
    RemoteDataSource
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}