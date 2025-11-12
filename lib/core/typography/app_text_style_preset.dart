part of typography;

class AppTextStylePreset {
  final TextStyle _style;

  AppTextStylePreset(this._style);

  AppTextStyleColor get color => AppTextStyleColor(_style);

  TextStyle get value => _style;
}

class AppTextStyleColor {
  final TextStyle _style;

  AppTextStyleColor(this._style);

  AppTextStylePreset get white => AppTextStylePreset(_style.copyWith(color: AppPallete.white));
  AppTextStylePreset get black => AppTextStylePreset(_style.copyWith(color: AppPallete.black));
}