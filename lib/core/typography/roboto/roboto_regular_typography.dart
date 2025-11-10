part of typography;

class RobotoRegularTypography {

  final Map<String, TextStyle> _map = {

    'base': const TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16,
    ),
    'lg': const TextStyle(
      fontFamily: 'Roboto',
      fontSize: 20,
    ),
    'xl': const TextStyle(
      fontFamily: 'Roboto',
      fontSize: 24,
    ),
  };

  TextStyle get _baseStyle => _map['base']!;
  TextStyle get _lgStyle => _map['lg']!;
  TextStyle get _xlStyle => _map['xl']!;

  TextStylePreset get base => TextStylePreset(_baseStyle);
  TextStylePreset get lg => TextStylePreset(_lgStyle);
  TextStylePreset get xl => TextStylePreset(_xlStyle);
}