import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/helpers/helpers.dart';
import '../../../domain/model/models.dart';
import '../../../domain/repository/settings_repository.dart';
import '../../../domain/repository/weather_repository.dart';
import '../widgets/widgets.dart';

part 'weather_forecast_event.dart';
part 'weather_forecast_state.dart';

class WeatherForecastBloc
    extends Bloc<WeatherForecastEvent, WeatherForecastState> {
  WeatherForecastBloc({
    required WeatherRepository weatherRepository,
    required SettingsRepository settingsRepository,
    required String query,
  })  : _query = query, _weatherRepository = weatherRepository,
        _settingsRepository = settingsRepository,
        super(WeatherForecastState(
            cityQuery: query, unit: settingsRepository.settings.unit)) {
    on<WeatherForecastFetchEvent>(_fetchWeatherForecast);
    on<WeatherForecastSelectItemEvent>(_onSelectItem);
    on<WeatherForecastSubscribeToSettingsEvent>(_onSubscribeToSettings);
  }

  final WeatherRepository _weatherRepository;
  final SettingsRepository _settingsRepository;
  final String _query;

  Future<void> _fetchWeatherForecast(
    WeatherForecastFetchEvent event,
    Emitter<WeatherForecastState> emit,
  ) async {
    if (_query.isEmpty) return;

    emit(state.copyWith(status: WeatherStatus.loading, cityQuery: _query));

    try {
      final weatherResult = await _weatherRepository.getForecastForCityName(
          query: _query, unit: _settingsRepository.settings.unit);

      emit(
        state.copyWith(
            status: WeatherStatus.success, weatherList: weatherResult),
      );
    } on Exception {
      emit(state.copyWith(status: WeatherStatus.failure, weatherList: []));
    }
  }

  Future<void> _onSubscribeToSettings(
    WeatherForecastSubscribeToSettingsEvent event,
    Emitter<WeatherForecastState> emit,
  ) async {
    await emit.forEach<Settings>(
      _settingsRepository.getSettings().skip(1), // Skip the first initial value
      onData: (settings) {
        add(WeatherForecastFetchEvent()); // Trigger a fetch when settings change
        return state.copyWith(unit: settings.unit);
      },
    );
  }

  Future<void> _onSelectItem(
    WeatherForecastSelectItemEvent event,
    Emitter<WeatherForecastState> emit,
  ) async {
    emit(state.copyWith(selectedIndex: event.index));
  }
}
