part of typography;

class AppTypographyFamilyPreset {

  final String fontName;
  final FontWeight fontWeight;

  AppTypographyFamilyPreset({required this.fontName, required this.fontWeight});

  late final Map<String, TextStyle> _map = {

    'base': TextStyle(
      fontFamily: this.fontName,
      fontSize: 16,
      fontWeight: this.fontWeight
    ),
    'lg': TextStyle(
      fontFamily: this.fontName,
      fontSize: 20,
      fontWeight: this.fontWeight
    ),
    'xl': TextStyle(
      fontFamily: this.fontName,
      fontSize: 24,
      fontWeight: this.fontWeight
    ),
  };

  TextStyle get _baseStyle => _map['base']!;
  TextStyle get _lgStyle => _map['lg']!;
  TextStyle get _xlStyle => _map['xl']!;

  AppTextStylePreset get base => AppTextStylePreset(_baseStyle);
  AppTextStylePreset get lg => AppTextStylePreset(_lgStyle);
  AppTextStylePreset get xl => AppTextStylePreset(_xlStyle);
}