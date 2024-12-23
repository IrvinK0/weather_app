import 'package:flutter/material.dart';

import '../../../core/helpers/helpers.dart';

class WeatherItemData {
  final String topText;
  final String icon;
  final String bottomText;

  WeatherItemData({
    required this.topText,
    required this.icon,
    required this.bottomText,
  });
}

class WeatherItem extends StatelessWidget {
  const WeatherItem({
    super.key,
    required this.item,
    required this.isSelected,
  });

  final WeatherItemData item;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ObjectKey(item),
      width: 160.0,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withAlpha(isSelected ? 255 : 150),
        borderRadius: BorderRadius.circular(20.0),
        border: isSelected
            ? Border.all(
                color: Colors.white,
                width: 3.0,
              )
            : null,
        boxShadow: [
          if (isSelected)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 8.0,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            item.topText,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Image.network(
            createIconUri(item.icon),
            width: 60,
            height: 60,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              );
            },
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.broken_image,
              color: Colors.white,
              size: 60,
            ),
          ),
          Text(
            item.bottomText,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white
                ),
          ),
        ],
      ),
    );
  }
}
