part of typography;

class RobotoMediumTypography {

  final Map<String, TextStyle> _map = {

    'base': const TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    'lg': const TextStyle(
      fontFamily: 'Roboto',
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    'xl': const TextStyle(
      fontFamily: 'Roboto',
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
  };

  TextStyle get _baseStyle => _map['base']!;
  TextStyle get _lgStyle => _map['lg']!;
  TextStyle get _xlStyle => _map['xl']!;

  ColorAccess get base => ColorAccess(_baseStyle);
  ColorAccess get lg => ColorAccess(_lgStyle);
  ColorAccess get xl => ColorAccess(_xlStyle);
}