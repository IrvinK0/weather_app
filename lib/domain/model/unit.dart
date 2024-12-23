enum Unit { metric, imperial }

extension UnitExtension on Unit {
  String get name {
    switch (this) {
      case Unit.metric:
        return 'metric';
      case Unit.imperial:
        return 'imperial';
    }
  }
}
