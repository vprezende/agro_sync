part of theme;

class AppTheme {
  static final lightThemeMode = ThemeData.light().copyWith(
    visualDensity: .adaptivePlatformDensity,
    appBarTheme: AppBarTheme.data,
    drawerTheme: AppDrawerTheme.data,
    floatingActionButtonTheme: AppFabTheme.data,
    iconButtonTheme: AppIconButtonTheme.data,
    textButtonTheme: AppTextButtonTheme.data,
    textSelectionTheme: AppTextSelectionTheme.data,
    inputDecorationTheme: AppInputTheme.data
  );
}