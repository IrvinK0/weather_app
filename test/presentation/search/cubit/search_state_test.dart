import 'package:flaconi_weather/presentation/search/search.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SearchState', () {
    test('supports value equality', () {
      // Two instances with the same text should be equal
      const state1 = SearchState(text: 'Berlin');
      const state2 = SearchState(text: 'Berlin');

      expect(state1, equals(state2));
    });

    test('isFormValid returns true when text is non-empty', () {
      const state = SearchState(text: 'Berlin');

      expect(state.isFormValid, isTrue);
    });

    test('isFormValid returns false when text is null', () {
      const state = SearchState(text: null);

      expect(state.isFormValid, isFalse);
    });

    test('isFormValid returns false when text is empty', () {
      const state = SearchState(text: '');

      expect(state.isFormValid, isFalse);
    });

    test('copyWith creates a new instance with updated text', () {
      const state = SearchState(text: 'Berlin');
      final newState = state.copyWith(text: 'Paris');

      expect(newState.text, equals('Paris'));
      expect(newState, isNot(equals(state)));
    });

    test('copyWith retains the original text if not provided', () {
      const state = SearchState(text: 'Berlin');
      final newState = state.copyWith();

      expect(newState.text, equals('Berlin'));
      expect(newState, equals(state));
    });
  });
}
