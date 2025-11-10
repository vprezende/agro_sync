part of typography;

class AppTextStylePreset {
  final TextStyle _style;

  AppTextStylePreset(this._style);

  AppTextStyleColors get color => AppTextStyleColors(_style);
}

class AppTextStyleColors {
  final TextStyle baseColor;

  AppTextStyleColors(this.baseColor);

  TextStyle get white => baseColor.copyWith(color: AppPallete.white);
  TextStyle get black => baseColor.copyWith(color: AppPallete.black);
}