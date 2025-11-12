part of theme;

class AppTextButtonTheme {
  static final data = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppPallete.white,
      textStyle: AppTypography
        .roboto
        .regular
        .base
        .value
    )
  );
}