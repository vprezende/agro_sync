import 'package:flutter/material.dart';
import 'package:geodesy/geodesy.dart';

import 'package:agro_sync/controllers/area_controller.dart';
import 'package:agro_sync/controllers/line_controller.dart';

class TreeController extends ChangeNotifier {

  final AreaController areaController;
  final LineController lineController;

  List<LatLng> treeMarkers = [];
  List<List<LatLng>> ranks = [];

  TreeController({
    required this.areaController,
    required this.lineController
  });

  void addRankTreeToArea(int areaIndex, int numTrees) {

    final allAreas = this.areaController.allAreas;
    final area = allAreas[areaIndex];
    final distance = const Distance();

    final numVertices = area.length;

    // Calcula o comprimento da área e de cada lado

    double areaLength = 0;
    final List<double> sideLengths = [];

    for (int i = 0; i < numVertices; i++) {

      final startPoint = area[i];
      final endPoint = area[(i + 1) % numVertices]; // Fecha a área conectando o último ponto ao primeiro

      final sideLength = distance(startPoint, endPoint);

      sideLengths.add(sideLength);
      areaLength += sideLength;
    }

    // Distribui as árvores ao longo da área
    for (int i = 0; i < numVertices; i++) {

      final startPoint = area[i];
      final endPoint = area[(i + 1) % numVertices];

      final sideLength = sideLengths[i];

      // Proporção do comprimento do lado atual em relação a área
      final sideRatio = sideLength / areaLength;

      // Quantidade de árvores a serem colocadas neste lado
      int treesForThisSide = (sideRatio * numTrees).round();

      // Distribui as árvores ao longo do lado atual
      for (int j = 0; j < treesForThisSide; j++) {

        double progress = (treesForThisSide == 1) ? 0.5 : (j / treesForThisSide);

        final deltaLat = endPoint.latitude - startPoint.latitude;
        final deltaLng = endPoint.longitude - startPoint.longitude;

        final deltaLatProgress = deltaLat * progress;
        final deltaLngProgress = deltaLng * progress;

        final lat = startPoint.latitude + deltaLatProgress;
        final lng = startPoint.longitude + deltaLngProgress;

        final point = LatLng(lat, lng);

        treeMarkers.add(point);
      }
    }

    ranks.add(treeMarkers);
    notifyListeners();
  }

  void addRankTreeToLine(int lineIndex, double spacingMeters) {

    final allLines = this.lineController.allLines;
    final line = allLines[lineIndex];

    final distance = const Distance();

    double accumulatedDistance = 0; // ignore: unused_local_variable

    // Percorre cada segmento da linha

    for (int i = 0; i < line.length - 1; i++) {
      final startPoint = line[i];
      final endPoint = line[i + 1];

      final segLen = distance(startPoint, endPoint);

      // número de árvores nesse segmento (inclui o início, mas não o fim)

      int numTrees = segLen ~/ spacingMeters;

      for (int j = 0; j <= numTrees; j++) {
        double segmentProgress = (j * spacingMeters) / segLen;

        if (segmentProgress > 1) break; // não ultrapassa o fim do segmento

        final deltaLat = endPoint.latitude - startPoint.latitude;
        final deltaLng = endPoint.longitude - startPoint.longitude;

        final deltaLatProgress = deltaLat * segmentProgress;
        final deltaLngProgress = deltaLng * segmentProgress;

        final lat = startPoint.latitude + deltaLatProgress;
        final lng = startPoint.longitude + deltaLngProgress;

        final point = LatLng(lat, lng);
        treeMarkers.add(point);
      }
      accumulatedDistance += segLen;
    }

    ranks.add(treeMarkers);
    notifyListeners();
  }

  void addTreeToArea(int areaIndex) {

    final allAreas = this.areaController.allAreas;

    final area = allAreas[areaIndex];

    final geodesy = Geodesy();

    final minLat = area.map((p) => p.latitude).reduce(min);
    final maxLat = area.map((p) => p.latitude).reduce(max);
    final minLng = area.map((p) => p.longitude).reduce(min);
    final maxLng = area.map((p) => p.longitude).reduce(max);

    final random = Random();

    // Calculando a variação da latitude e longitude da área

    final deltaLat = maxLat - minLat;
    final deltaLng = maxLng - minLng;

    // Gera coordenadas aleatórias dentro do retângulo delimitador da área

    final lat = minLat + (random.nextDouble() * deltaLat);
    final lng = minLng + (random.nextDouble() * deltaLng);

    // Gerando o ponto dentro dos limites da área

    final point = LatLng(lat, lng);

    if (geodesy.isGeoPointInPolygon(point, area)) {
      treeMarkers.add(point);
      notifyListeners();
    }
  }
}