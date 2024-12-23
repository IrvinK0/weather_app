import 'package:flaconi_weather/presentation/search/cubit/search_cubit.dart';
import 'package:flaconi_weather/presentation/search/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../pump_app.dart';
import 'package:bloc_test/bloc_test.dart';

class MockSearchCubit extends MockCubit<SearchState> implements SearchCubit {}

void main() {
  group('SearchView', () {
    late SearchCubit searchCubit;

    setUp(() {
      searchCubit = MockSearchCubit();
      when(() => searchCubit.state).thenReturn(const SearchState(text: ''));
      when(() => searchCubit.textChanged(any())).thenAnswer((_) async {});
    });

    Widget buildSubject() {
      return BlocProvider.value(
        value: searchCubit,
        child: const SearchView(),
      );
    }

    testWidgets(
      'renders AppBar with title',
      (tester) async {
        await tester.pumpApp(buildSubject());

        expect(find.byType(AppBar), findsOneWidget);

        expect(
          find.descendant(
            of: find.byType(AppBar),
            matching: find.text('Search City'),
          ),
          findsOneWidget,
        );

        await tester.pumpAndSettle();
      },
    );

    testWidgets('renders a text field and search button',
        (WidgetTester tester) async {
      await tester.pumpApp(buildSubject());

      expect(find.byType(TextField), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(TextField),
          matching: find.text('Enter city name'),
        ),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('textChanged when text changes', (tester) async {
      await tester.pumpApp(buildSubject());
      await tester.enterText(find.byKey(Key('search_input')), 'city');
      verify(() => searchCubit.textChanged('city')).called(1);
    });
  });
}
