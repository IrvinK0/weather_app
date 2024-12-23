import 'package:flutter/material.dart';

import '../search/view/view.dart';
import '../settings/view/settings_page.dart';
import '../weather_forecast/view/view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SearchPage());
      case '/weather_forecast':
        final args = settings.arguments;
        if (args is Map<String, String>) {
          final query = args['city'] ?? '';
          return WeatherForecastPage.route(query: query);
        } else {
          return _errorRoute('Invalid arguments for Weather Forecast Page');
        }
      case '/settings':
        return SettingsPage.route();
      default:
        return _errorRoute('Page not found');
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(child: Text(message)),
      ),
    );
  }
}
