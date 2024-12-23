import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/model/models.dart';
import '../../../domain/repository/settings_repository.dart';
import '../cubit/settings_cubit.dart';
import 'settings_view.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static Route<Settings> route() {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => SettingsCubit(context.read<SettingsRepository>()),
        child: SettingsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SettingsView();
  }
}
