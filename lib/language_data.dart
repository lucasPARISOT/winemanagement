import 'package:winemanagement/language_flag.dart';

class LanguageData {

  static final List<String> countries = [
    'English',
    'French',
    'Spanish',
    'Portuguese',
    'Italian',
    'Greek',
    'German',
    'Russian'
  ];

  static final List<String> locale = [
    'EN',
    'FR',
    'ES',
    'PT',
    'IT',
    'GR',
    'DE',
    'RU'
  ];

  static final List<LanguageFlag> languageFlag =
    List.generate(countries.length, (index) =>
      LanguageFlag(
        language: countries.elementAt(index),
        locale: locale.elementAt(index)
      )
  );

  List<LanguageFlag> getSuggestions(String query) {
    return List.of(languageFlag).where((languageFlagElement) {

      // English language string
      final language = languageFlagElement.language.toLowerCase();

      final queryLower = query.toLowerCase();

      return language.contains(queryLower);
    }).toList();
  }
}