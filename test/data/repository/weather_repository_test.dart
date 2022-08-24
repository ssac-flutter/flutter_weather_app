import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/data/data_source/open_weather_api.dart';
import 'package:weather_app/data/data_source/open_weather_api_impl.dart';
import 'package:weather_app/data/data_source/weather_dto.dart';
import 'package:weather_app/data/repository/weather_repository.dart';

import '../data_source/open_weather_api_test.dart';
import 'weather_repository_test.mocks.dart';

@GenerateMocks([OpenWeatherApi])
void main() {
  test('날씨 정보가 잘 들어와야 된다', () async {
    final api = MockOpenWeatherApi();

    when(api.getWeatherInfo('suwon'))
        .thenAnswer((_) async => WeatherDto.fromJson(jsonDecode(fakeData)));

    final repository = WeatherRepository(api);

    final weather = await repository.getWeatherInfo('suwon');

    expect(weather.cityName, 'Suwon-si');
  });
}
