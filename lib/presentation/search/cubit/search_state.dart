part of 'search_cubit.dart';

class SearchState extends Equatable {
  final String? text;

  const SearchState({this.text});

  bool get isFormValid => text?.isNotEmpty ?? false;

  @override
  List<Object?> get props => [text];

  SearchState copyWith({String? text}) {
    return SearchState(text: text ?? this.text);
  }
}

