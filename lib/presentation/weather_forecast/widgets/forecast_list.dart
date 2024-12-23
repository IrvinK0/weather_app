import 'package:flutter/material.dart';

import 'widgets.dart';

class ForecastList extends StatelessWidget {
  const ForecastList({
    required this.items,
    required this.onTap,
    required this.selectedIndex,
    super.key,
  });

  final List<WeatherItemData> items;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 170.0,
          child: ListView.builder(
            itemCount: items.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemBuilder: (BuildContext context, int index) {
              final isSelected = selectedIndex == index;
              return GestureDetector(
                onTap: () => _handleTap(index),
                child: WeatherItem(
                  item: items[index],
                  isSelected: isSelected,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _handleTap(int index) {
    onTap(index);
  }
}
