import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({String initialText = 'Berlin'})
      : super(SearchState(text: initialText)); // Set default 'Berlin' as initial value

  /// Updates the search text in the state.
  /// 
  /// [value] is the new search text entered by the user.
  void textChanged(String value) {
    emit(state.copyWith(text: value));
  }
}
