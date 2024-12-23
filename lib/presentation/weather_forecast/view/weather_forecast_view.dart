import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/weather_forecast_bloc.dart';
import '../widgets/widgets.dart';

class WeatherForecastView extends StatelessWidget {
  const WeatherForecastView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context
            .select((WeatherForecastBloc cubit) => cubit.state.cityQuery)),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).pushNamed('/settings'),
              icon: Icon(Icons.settings))
        ],
      ),
      body: Center(
        child: BlocBuilder<WeatherForecastBloc, WeatherForecastState>(
          builder: (context, state) {
            return _buildWidget(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildWidget(BuildContext context, WeatherForecastState state) {
    return switch (state.status) {
      WeatherStatus.loading => const WeatherLoading(),
      WeatherStatus.failure => WeatherError(
          onTap: () => _fetchWeatherForecast(context),
        ),
      WeatherStatus.success => _buildSuccessState(context, state)
    };
  }

  /// Fetches the weather forecast when the error screen is tapped.
  void _fetchWeatherForecast(BuildContext context) {
    context.read<WeatherForecastBloc>().add(WeatherForecastFetchEvent());
  }

  /// Builds the success state with the forecast data.
  Widget _buildSuccessState(BuildContext context, WeatherForecastState state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<WeatherForecastBloc>().add(WeatherForecastFetchEvent());
      },
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  WeatherDetails(data: state.weatherDetailsData),
                  const SizedBox(height: 24),
                  Text(
                    '7 days forecast',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  ForecastList(
                    items: state.weatherItemData,
                    selectedIndex: state.selectedIndex,
                    onTap: (index) => _selectItem(context, index),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Selects a weather item from the list.
  void _selectItem(BuildContext context, int index) {
    context
        .read<WeatherForecastBloc>()
        .add(WeatherForecastSelectItemEvent(index: index));
  }
}
