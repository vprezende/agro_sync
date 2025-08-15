import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:geodesy/geodesy.dart';
import 'package:provider/provider.dart';

// importando os controllers

import 'package:agro_sync/controllers/drawer_state_controller.dart';
import 'package:agro_sync/controllers/line_controller.dart';
import 'package:agro_sync/controllers/tree_controller.dart';

// importando widgets

import 'package:agro_sync/widgets/area_dialog.dart';
import 'package:agro_sync/widgets/app_drawer.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  int treeCounter = 0;

  final AppDrawer appDrawer = const AppDrawer();

  @override
  Widget build(BuildContext context) {

    final treeController = context.watch<TreeController>();
    final lineController = context.watch<LineController>();

    final drawerStateController = context.watch<DrawerStateController>();
    final areaController = treeController.areaController;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        toolbarHeight: (56 + 20),
        leadingWidth: 75,
        leading: Builder(
          builder: (context) {
            return Container(
              margin: const EdgeInsets.only(top: 20, left: 20),
              child: FloatingActionButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                child: const Icon(Icons.menu),
              ),
            );
          },
        ),
      ),
      drawer: appDrawer,
      body: FlutterMap(
        options: MapOptions(
          initialCenter: const LatLng(-21.1358, -41.68),
          initialZoom: 13,
          minZoom: 3,
          maxZoom: 17,
          onTap: ((_, point) {
            if (areaController.isAddingPoints) {
              setState(() => areaController.addPoint(point));
            }
          }),
          // Impedindo que o usuário ultrapasse a borda inferior e superior do mapa
          cameraConstraint: CameraConstraint.contain(
            bounds: LatLngBounds(
              const LatLng(-85.0511, -180), // Limite inferior da projeção Mercator
              const LatLng(85.0511, 180), // Limite superior da projeção Mercator
            ),
          ),
        ),
        children: [
          TileLayer(
            tileProvider: CancellableNetworkTileProvider(),
            urlTemplate: 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
            userAgentPackageName: 'dev.fleaflet.flutter_map.imagery'
          ),

          TileLayer(
            tileProvider: CancellableNetworkTileProvider(),
            urlTemplate: 'https://services.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/MapServer/tile/{z}/{y}/{x}',
            userAgentPackageName: 'dev.fleaflet.flutter_map.labels',
          ),

          // Camada para exibir os pontos da tela
          MarkerLayer(
            markers: areaController.currentArea.map((point) {
              return Marker(
                point: point,
                width: 12,
                height: 12,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                ),
              );
            }).toList(),
          ),

          // Camada para desenhar o polígono ou conectar os pontos
          // por meio de uma linha

          drawerStateController.dropValue == 'Rank em Nível'
            ? PolygonLayer(
                polygons: areaController.allAreas.map((polygon) {
                  return Polygon(
                    points: polygon,
                    color: Colors.blue.withAlpha(80),
                    borderStrokeWidth: 3.0,
                    borderColor: Colors.blue,
                  );
                }).toList(),
              )
            : drawerStateController.dropValue.isNotEmpty
              ? PolylineLayer(
                  polylines: lineController.allLines.map((points) {
                    return Polyline(
                      points: points,
                      color: Colors.blue,
                      strokeWidth: 4.0
                    );
                  }).toList()
                )
              : const SizedBox.shrink(),

          MarkerLayer(
            markers: treeController.treeMarkers.map((point) {
              return Marker(
                point: point,
                width: 24,
                height: 24,
                child: Icon(Icons.park, color: Colors.green.shade800),
              );
            }).toList(),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          if (drawerStateController.dropValue.isNotEmpty) ...[

            FloatingActionButton(
              onPressed: () {
                setState(() {
                  areaController.isAddingPoints = !areaController.isAddingPoints;
                });
              },
              backgroundColor: areaController.isAddingPoints ? Colors.green : Colors.blue,
              child: Icon(areaController.isAddingPoints ? Icons.add_location_alt : Icons.add_location_alt_outlined,),
            ),

            const SizedBox(height: 25),

            FloatingActionButton(
              onPressed: () {
                setState(() {
                  drawerStateController.dropValue == 'Rank em Nível'
                    ? areaController.closeArea(context)
                    : lineController.connectPoints(context);
                });
              },
              child: Icon(
                drawerStateController.dropValue == 'Rank em Nível'
                  ? Icons.crop_square
                  : Icons.linear_scale
              )
            ),

            const SizedBox(height: 25),

            FloatingActionButton(
              onPressed: () {
                setState(() {
                  drawerStateController.dropValue == 'Rank em Nível'
                    ? areaController.resetArea()
                    : lineController.resetLines();
                });
              },
              child: const Icon(Icons.delete)
            ),

            const SizedBox(height: 25),

            FloatingActionButton(
              onPressed: () {
                setState(() {
                  drawerStateController.dropValue == 'Rank em Nível'
                    ? areaController.undoArea()
                    : lineController.undoLine();
                });
              },
              child: const Icon(Icons.undo)
            ),

            const SizedBox(height: 25),

            FloatingActionButton(
              onPressed: () => AreaDialog.show(context, areaController),
              child: const Icon(Icons.info),
            ),
          ]
        ],
      ),
    );
  }
}