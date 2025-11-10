part of theme;

class AppInputTheme {
  static final data = InputDecorationThemeData(
    filled: true,
    fillColor: AppPallete.white,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none
    ),
  );
}