import 'package:flutter/material.dart';
import 'package:agro_sync/controllers/line_controller.dart';
import 'package:agro_sync/controllers/tree_controller.dart';

class DrawerStateController extends ChangeNotifier {

  final TreeController treeController;
  final LineController lineController;

  int treeCounter = 0;

  final radioOptions = ['unidade', 'rank'];
  final dropOptions = ['Rank em Nível', 'Rank Linear'];

  String radioValue = 'unidade';
  String dropValue = '';

  int selectedAreaIndex = -1;
  int selectedLineIndex = -1;

  DrawerStateController({
    required this.treeController,
    required this.lineController
  });

  void incrementTreeCounter() {
    treeCounter++;
    notifyListeners();
  }

  void decrementTreeCounter() {
    if (treeCounter > 0) {
      treeCounter--;
      notifyListeners();
    }
  }

  void setRadioValue(String value) {
    radioValue = value;
    notifyListeners();
  }

  void setDropValue(String value) {
    dropValue = value;
    notifyListeners();
  }

  void setAreaIndex(int index) {
    selectedAreaIndex = index;
    notifyListeners();
  }

  void setLineIndex(int index) {
    selectedLineIndex = index;
    notifyListeners();
  }

  void reset() {

    radioValue = radioOptions.first;
    dropValue = '';

    selectedAreaIndex = -1;
    selectedLineIndex = -1;

    treeCounter = 0;

    treeController.treeMarkers = [];

    treeController.areaController.isAddingPoints = false;

    treeController.areaController.resetArea();
    lineController.resetLines();

    notifyListeners();
  }
}
