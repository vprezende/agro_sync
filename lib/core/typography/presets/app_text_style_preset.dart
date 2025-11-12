part of typography;

class AppTextStylePreset {
  final TextStyle _style;

  AppTextStylePreset(this._style);

  TextStyle get value => _style;

  AppTextStyleColor get color => AppTextStyleColor(_style);
}

class AppTextStyleColor {
  final TextStyle _style;

  AppTextStyleColor(this._style);

  AppTextStyleColored get white => AppTextStyleColored(_style.copyWith(color: AppPallete.white));
  AppTextStyleColored get black => AppTextStyleColored(_style.copyWith(color: AppPallete.black));
}

class AppTextStyleColored {
  final TextStyle _style;

  AppTextStyleColored(this._style);

  TextStyle get value => _style;
}