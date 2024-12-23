import 'package:bloc_test/bloc_test.dart';
import 'package:flaconi_weather/presentation/search/search.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SearchCubit', () {
    test('initial state is SearchState with empty text', () {
      final cubit = SearchCubit();
      expect(cubit.state, const SearchState(text: 'Berlin'));
    });

    blocTest<SearchCubit, SearchState>(
      'emits updated state when textChanged is called',
      build: () => SearchCubit(),
      act: (cubit) => cubit.textChanged('Berlin'),
      expect: () => [const SearchState(text: 'Berlin')],
    );
  });
}
