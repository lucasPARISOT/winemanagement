class LanguageData {
  List<Map<String, String>> getLanguage(String query) {

    final List<String> countries = [
      'English',
      'French',
      'Spanish',
      'Portuguese',
      'Italian',
      'Greek',
      'German'
    ];

    final List<String> locale = [
      'EN',
      'FR',
      'ES',
      'PT',
      'IT',
      'GR',
      'DE'
    ];

    return List.generate(countries.length, (index) {
      return {
        'language': countries.elementAt(index),
        'locale': locale.elementAt(index)
      };
    });
  }
}