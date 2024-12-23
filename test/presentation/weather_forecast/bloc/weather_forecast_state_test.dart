import 'package:flaconi_weather/domain/model/models.dart';
import 'package:flaconi_weather/presentation/weather_forecast/bloc/weather_forecast_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WeatherForecastState', () {
    test('has correct default state', () {
      const state = WeatherForecastState();

      expect(state.status, equals(WeatherStatus.loading));
      expect(state.cityQuery, isEmpty);
      expect(state.weatherList, isEmpty);
      expect(state.selectedIndex, 0);
      expect(state.unit, Unit.metric);
    });

    test('supports value equality', () {
      // Two instances with the same status should be equal
      const state1 = WeatherForecastState(
          status: WeatherStatus.loading, cityQuery: 'Berlin');
      const state2 = WeatherForecastState(
          status: WeatherStatus.loading, cityQuery: 'Berlin');

      expect(state1, equals(state2));
    });

    test('copyWith creates a new instance with updated status', () {
      const state = WeatherForecastState(status: WeatherStatus.loading);
      final newState = state.copyWith(status: WeatherStatus.success);

      expect(newState.status, equals(WeatherStatus.success));
      expect(newState, isNot(equals(state)));
    });

    test('copyWith retains the original status if not provided', () {
      const state = WeatherForecastState(
        status: WeatherStatus.loading,
        cityQuery: 'Berlin',
      );
      final newState = state.copyWith();

      expect(newState.status, equals(WeatherStatus.loading));
      expect(newState, equals(state));
    });
  });
}
