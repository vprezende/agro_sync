part of typography;

class MonospaceRegularTypography {

  final Map<String, TextStyle> _map = {

    'base': const TextStyle(
      fontFamily: 'Monospace',
      fontSize: 16,
    ),
    'lg': const TextStyle(
      fontFamily: 'Monospace',
      fontSize: 20,
    ),
    'xl': const TextStyle(
      fontFamily: 'Monospace',
      fontSize: 24,
    ),
  };

  TextStyle get _baseStyle => _map['base']!;
  TextStyle get _lgStyle => _map['lg']!;
  TextStyle get _xlStyle => _map['xl']!;

  ColorAccess get base => ColorAccess(_baseStyle);
  ColorAccess get lg => ColorAccess(_lgStyle);
  ColorAccess get xl => ColorAccess(_xlStyle);
}