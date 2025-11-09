part of theme;

class AppTheme {

  static final lightThemeMode = ThemeData.light().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(
      backgroundColor: AppPallete.transparent,
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: AppPallete.grey300,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: AppPallete.white,
      backgroundColor: AppPallete.blue,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: AppPallete.white,
      )
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppPallete.white,
        textStyle: AppTypography
          .roboto
          .regular
          .base
          .white
      )
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppPallete.grey500_60p
    ),
    inputDecorationTheme: InputDecorationThemeData(
      filled: true,
      fillColor: AppPallete.white,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none
      ),
    ),
  );
}