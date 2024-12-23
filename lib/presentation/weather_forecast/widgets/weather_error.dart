import 'package:flutter/material.dart';

class WeatherError extends StatelessWidget {
  const WeatherError({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text('Retry'),
      ),
    );
  }
}
