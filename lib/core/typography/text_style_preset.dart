part of typography;

class TextStylePreset {
  final TextStyle _style;

  TextStylePreset(this._style);

  TextStyleColors get color => TextStyleColors(_style);
}

class TextStyleColors {
  final TextStyle baseColor;

  TextStyleColors(this.baseColor);

  TextStyle get white => baseColor.copyWith(color: AppPallete.white);
  TextStyle get black => baseColor.copyWith(color: AppPallete.black);
}