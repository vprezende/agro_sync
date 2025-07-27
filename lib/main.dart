import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ilpf/controllers/area_controller.dart';
import 'package:ilpf/controllers/drawer_state_controller.dart';
import 'package:ilpf/controllers/line_controller.dart';
import 'package:ilpf/controllers/tree_controller.dart';

import 'package:ilpf/screens/map_screen.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue
        ).copyWith(
          primary: Colors.blue,
          primaryContainer: Colors.blue,
          onPrimaryContainer: Colors.white
        ),
      ),
      home: const MapScreen(),
    );
  }
}