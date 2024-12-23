part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final Settings settings;

  const SettingsState({required this.settings});

  /// Whether the unit of measurement is set to imperial.
  bool get isImperial => settings.unit == Unit.imperial;

  /// Values for toggling between measurement units.
  /// Returns a list where the first value represents the current unit state.
  List<bool> get unitSwitchValues => [isImperial];

  SettingsState copyWith({
    Settings? settings,
  }) {
    return SettingsState(
      settings: settings ?? this.settings,
    );
  }

  @override
  List<Object?> get props => [settings];
}
