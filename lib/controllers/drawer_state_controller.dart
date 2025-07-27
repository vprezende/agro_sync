import 'package:flutter/material.dart';
import 'package:ilpf/controllers/line_controller.dart';
import 'package:ilpf/controllers/tree_controller.dart';

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

  incrementTreeCounter() {
    treeCounter++;
    notifyListeners();
  }

  decrementTreeCounter() {
    if (treeCounter > 0) {
      treeCounter--;
      notifyListeners();
    }
  }

  setRadioValue(String value) {
    radioValue = value;
    notifyListeners();
  }

  setDropValue(String value) {
    dropValue = value;
    notifyListeners();
  }

  setAreaIndex(int index) {
    selectedAreaIndex = index;
    notifyListeners();
  }

  setLineIndex(int index) {
    selectedLineIndex = index;
    notifyListeners();
  }

  reset() {

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
