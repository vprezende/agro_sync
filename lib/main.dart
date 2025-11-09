import "package:flutter/material.dart";
import "core/theme/theme.dart";

import "package:provider/provider.dart";
import "presenters/presenters.dart";

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AreaController()),
        ChangeNotifierProvider(create: (context) => LineController(
          areaController: context.read<AreaController>(),
        )),
        ChangeNotifierProvider(create: (context) => TreeController(
          areaController: context.read<AreaController>(),
          lineController: context.read<LineController>()
        )),
        ChangeNotifierProvider(create: (context) => DrawerStateController(
          treeController: context.read<TreeController>(),
          lineController: context.read<LineController>()
        )),
      ],
      child: const HomeScreen(),
    )
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightThemeMode,
      home: const MapScreen(),
    );
  }
}