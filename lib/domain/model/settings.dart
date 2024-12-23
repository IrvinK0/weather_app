import 'package:equatable/equatable.dart';

import 'models.dart';

class Settings extends Equatable {
  final Unit unit;

  const Settings({required this.unit});

  Settings copyWith({
    Unit? unit,
  }) {
    return Settings(
      unit: unit ?? this.unit,
    );
  }

  @override
  List<Object?> get props => [unit];
}
