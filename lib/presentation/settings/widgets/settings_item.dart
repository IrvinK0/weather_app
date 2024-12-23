import 'package:flutter/material.dart';

class SettingsSwitchItemData {
  final String title;
  final String subtitle;
  final bool isOn;

  SettingsSwitchItemData(
      {required this.title, required this.subtitle, required this.isOn});
}

class SettingsSwitchItem extends StatelessWidget {
  const SettingsSwitchItem({
    super.key,
    required this.data,
    required this.onChanged,
  });

  final Function(bool) onChanged;
  final SettingsSwitchItemData data;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.title),
            Text(
              data.subtitle,
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
        Spacer(),
        Switch(
          value: data.isOn,
          onChanged: onChanged,
        )
      ],
    );
  }
}
