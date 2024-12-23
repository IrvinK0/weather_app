import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../weather_forecast/view/weather_forecast_page.dart';
import '../cubit/search_cubit.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search City')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            return Row(
              children: [
                Expanded(
                  child: _SearchInputField(
                    text: state.text,
                    isFormValid: state.isFormValid,
                  ),
                ),
                _SearchButton(
                  isFormValid: state.isFormValid,
                  query: state.text ?? '',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SearchInputField extends StatelessWidget {
  const _SearchInputField({
    required this.text,
    required this.isFormValid,
  });

  final String? text;
  final bool isFormValid;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: const Key('search_input'),
      initialValue: text,
      onChanged: (text) => context.read<SearchCubit>().textChanged(text),
      decoration: InputDecoration(
        labelText: 'Enter city name',
        hintText: 'Berlin',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onEditingComplete: () {
        if (isFormValid) {
          Navigator.of(context).push(WeatherForecastPage.route(query: text ?? ''));
        }
      },
    );
  }
}

class _SearchButton extends StatelessWidget {
  const _SearchButton({
    required this.isFormValid,
    required this.query,
  });

  final bool isFormValid;
  final String query;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: const Key('search_iconButton'),
      icon: const Icon(Icons.search, semanticLabel: 'Submit'),
      onPressed: isFormValid
          ? () => Navigator.of(context).pushNamed(
                '/weather_forecast',
                arguments: {'city': query},
              )
          : null,
    );
  }
}
