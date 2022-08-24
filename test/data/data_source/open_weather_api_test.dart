import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:weather_app/data/data_source/open_weather_api_impl.dart';
import 'package:weather_app/data/data_source/weather_dto.dart';

void main() {
  test('날씨 정보는 잘 들어와야 된다', () async {
    final mockClient = MockClient((request) async {
      if (request.url.toString() == 'https://api.openweathermap.org/data/2.5/weather?q=suwon&appid=95114a1e948559e010396b4debdf1672') {
        return Response(fakeData, 200);
      }
      return Response('error', 404);
    });
    
    final api = OpenWeatherApiImpl(client: mockClient);

    WeatherDto weather = await api.getWeatherInfo('suwon');

    expect(weather.name, 'Suwon-si');
    expect(weather.weather![0].main, 'Clouds');
  });
}

const fakeData = """
{
  "coord": {
    "lon": 127.0089,
    "lat": 37.2911
  },
  "weather": [
    {
      "id": 804,
      "main": "Clouds",
      "description": "overcast clouds",
      "icon": "04d"
    }
  ],
  "base": "stations",
  "main": {
    "temp": 301.54,
    "feels_like": 302.48,
    "temp_min": 298.55,
    "temp_max": 301.79,
    "pressure": 1008,
    "humidity": 54
  },
  "visibility": 10000,
  "wind": {
    "speed": 0.51,
    "deg": 10
  },
  "clouds": {
    "all": 100
  },
  "dt": 1661321674,
  "sys": {
    "type": 1,
    "id": 5509,
    "country": "KR",
    "sunrise": 1661288133,
    "sunset": 1661336029
  },
  "timezone": 32400,
  "id": 1835553,
  "name": "Suwon-si",
  "cod": 200
}
""";