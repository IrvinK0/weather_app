import 'package:flutter/material.dart';

class WeatherLoading extends StatelessWidget {
  const WeatherLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Text('Loading weather forecast'),
        const Padding(
          padding: EdgeInsets.all(26),
          child: CircularProgressIndicator(),
        ),
        Spacer(),
      ],
    );
  }
}
