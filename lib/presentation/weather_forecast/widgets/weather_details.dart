import 'package:flutter/material.dart';

import '../../../core/helpers/helpers.dart';

class WeatherDetailsData {
  final String topText;
  final String middleText;
  final String icon;
  final String middleText1;
  final String bottomText;
  final String bottomText1;
  final String bottomText2;

  WeatherDetailsData({
    required this.topText,
    required this.middleText,
    required this.icon,
    required this.middleText1,
    required this.bottomText,
    required this.bottomText1,
    required this.bottomText2,
  });
}

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({super.key, required this.data});

  final WeatherDetailsData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              data.topText,
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            data.middleText,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.start,
          ),
          Center(
            child: Column(
              children: [
                Image.network(
                  createIconUri(data.icon),
                  width: 150,
                  height: 150,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.broken_image,
                    size: 150,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  data.middleText1,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _buildDetails(context),
        ],
      ),
    );
  }

  Widget _buildDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailItem(context, data.bottomText),
        _buildDetailItem(context, data.bottomText1),
        _buildDetailItem(context, data.bottomText2),
      ],
    );
  }

  Widget _buildDetailItem(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
