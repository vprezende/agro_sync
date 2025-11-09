part of presenters;

class LineController extends ChangeNotifier {

  final AreaController areaController;

  late List<LatLng> currentArea = areaController.currentArea;

  final List<List<LatLng>> _lines = [];

  LineController({required this.areaController});

  void connectPoints(BuildContext context) {
    if (currentArea.length < 2) {
      errorSnackBar(
        context,
        message: "Para criar uma linha, adicione pelo menos 2 pontos"
      );
      return;
    }

    this._lines.add([...currentArea]);
    currentArea.clear();
    notifyListeners();
  }

  void resetLines() {
    currentArea.clear();
    this._lines.clear();
  }

  void undoLine() {

    // remove os pontos quando clicar em 'undo'
    // quando a linha não foi fechada
    if (currentArea.isNotEmpty) {
      currentArea.removeLast();
      return;
    }

    if (this._lines.isEmpty) {
      return;
    }

    // Pega a última linha adicionada
    List<LatLng> lastLine = this._lines.last;

    // Verifica se a última linha tem mais de um ponto
    if (lastLine.length > 1) {

      lastLine.removeLast();

      if (lastLine.length < 2) {
        // Se sobrar menos de 2 pontos, removemos a linha toda
        this._lines.removeLast();
      }
      return;
    }
    this._lines.removeLast();
  }

  List<List<LatLng>> get allLines => [...this._lines];
}