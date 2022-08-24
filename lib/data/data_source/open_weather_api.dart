import 'package:weather_app/data/data_source/weather_dto.dart';

abstract class OpenWeatherApi {
  Future<WeatherDto> getWeatherInfo(String query);
}