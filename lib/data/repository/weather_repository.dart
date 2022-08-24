import 'package:weather_app/data/data_source/open_weather_api.dart';
import 'package:weather_app/data/model/weather.dart';

class WeatherRepository {
  final OpenWeatherApi _api;

  WeatherRepository(this._api);

  Future<Weather> getWeatherInfo(String query) async {
    final weatherDto = await _api.getWeatherInfo(query);

    final icon =
        'http://openweathermap.org/img/w/${weatherDto.weather?.elementAt(0).icon}';

    return Weather(
      weather: weatherDto.weather?.elementAt(0).main ?? '',
      cityName: weatherDto.name ?? '',
      icon: icon,
      temp: weatherDto.main?.temp ?? 0,
    );
  }
}
