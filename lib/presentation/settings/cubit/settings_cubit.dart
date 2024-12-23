import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/model/models.dart';
import '../../../domain/repository/settings_repository.dart';

part 'settings_state.dart';

/// A [Cubit] that manages the application's settings state.
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._settingsRepository)
      : super(SettingsState(settings: _settingsRepository.settings));

  final SettingsRepository _settingsRepository;

  /// Toggles the unit of measurement between metric and imperial.
  ///
  /// [newValue]: A boolean where `true` represents imperial units
  /// and `false` represents metric units.
  void toggleUnit(bool newValue) {
    final newSettings =
        state.settings.copyWith(unit: newValue ? Unit.imperial : Unit.metric);

    try {
      // Update the repository with the new settings.
      _settingsRepository.updateUnitSettings(newSettings);

      // Emit the updated state.
      emit(state.copyWith(settings: newSettings));
    } catch (error) {
      // Log or handle errors if repository operations fail.
      addError('Failed to update settings: $error', StackTrace.current);
    }
  }
}

