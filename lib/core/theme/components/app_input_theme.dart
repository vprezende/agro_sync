part of theme;

class AppInputTheme {
  static final data = InputDecorationThemeData(
    filled: true,
    fillColor: AppPallete.white,
    floatingLabelBehavior: .never,
    border: OutlineInputBorder(
      borderRadius: .circular(8),
      borderSide: .none
    ),
  );
}