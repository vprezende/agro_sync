part of typography;

class ColorAccess {
  final TextStyle base;

  ColorAccess(this.base);

  TextStyle get white => base.copyWith(color: AppPallete.white);
  TextStyle get black => base.copyWith(color: AppPallete.black);
}
