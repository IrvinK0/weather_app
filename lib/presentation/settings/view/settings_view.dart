import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/settings_cubit.dart';
import '../widgets/view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.unitSwitchValues.length,
              itemBuilder: (context, index) {
                final switchItem = state.unitSwitchValues[index];
                return SettingsSwitchItem(
                  data: SettingsSwitchItemData(
                    title: 'Units of measurement',
                    subtitle: 'Use imperial units.',
                    isOn: switchItem,
                  ),
                  onChanged: (value) {
                    context.read<SettingsCubit>().toggleUnit(value); // Trigger toggleUnit method on change
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
