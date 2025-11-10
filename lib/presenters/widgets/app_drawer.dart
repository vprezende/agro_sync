part of presenters;

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  late AreaController areaController;
  late TreeController treeController;
  late LineController lineController;

  late final TextEditingController _spacingController;

  @override
  void initState() {
    super.initState();
    _spacingController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    treeController = Provider.of<TreeController>(context);
    lineController = Provider.of<LineController>(context);
    areaController = treeController.areaController;
  }

  @override
  void dispose() {
    _spacingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final drawerWidth = screenWidth * 0.3;

    final drawerStateController = context.watch<DrawerStateController>();
    int treeCounter = drawerStateController.treeCounter;

    return Drawer(
      width: drawerWidth,
      child: ListView(
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(color: AppPallete.lightBlue),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: drawerStateController.dropValue.isEmpty,
                  child: DropdownMenu<String>(
                    value: (drawerStateController.dropValue.isEmpty)
                      ? null
                      : drawerStateController.dropValue,
                    hintText: 'Selecione o tipo de rank',
                    onChanged: (op) =>
                      drawerStateController.setDropValue(op.toString()),
                    items: drawerStateController.dropOptions
                      .map(
                        (op) => DropdownMenuItem(
                          value: op,
                          child: Center(child: Text(op)),
                        ),
                      )
                      .toList(),
                  ),
                ),
                Visibility(
                  visible: drawerStateController.dropValue == 'Rank em Nível',
                  child: Column(
                    children: [
                      DropdownMenu<int>(
                        value: drawerStateController.selectedAreaIndex == -1
                          ? null
                          : drawerStateController.selectedAreaIndex,
                        hintText: 'Selecione uma área',
                        items: List.generate(areaController.allAreas.length, (
                          index,
                        ) {
                          return DropdownMenuItem(
                            value: index,
                            child: Center(child: Text('area_${index + 1}')),
                          );
                        }),
                        onChanged: (index) {
                          setState(
                            () => drawerStateController.setAreaIndex(index!),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: RadioGroup<String>(
                              groupValue: drawerStateController.radioValue,
                              onChanged: (value) => drawerStateController.setRadioValue(value!),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: drawerStateController.radioOptions.map((op) {
                                  return Row(
                                    children: [
                                      Radio<String>(
                                        value: op,
                                        visualDensity: VisualDensity.compact,
                                        fillColor: WidgetStatePropertyAll(AppPallete.white),
                                      ),
                                      Text(
                                        op,
                                        style: AppTypography
                                          .roboto
                                          .regular
                                          .base
                                          .color
                                          .white
                                      ),
                                      const SizedBox(width: 16)
                                    ],
                                  );
                                }).toList(),
                              ),
                            )
                          ),
                          TextButton.icon(
                            icon: const Icon(Icons.arrow_back),
                            label: const Text('Voltar'),
                            onPressed: () => drawerStateController.reset(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                if (drawerStateController.dropValue == 'Rank Linear') ...[
                  DropdownMenu<int>(
                    value: drawerStateController.selectedLineIndex == -1
                      ? null
                      : drawerStateController.selectedLineIndex,
                    hintText: 'Selecione uma linha',
                    items: List.generate(lineController.allLines.length, (
                      index,
                    ) {
                      return DropdownMenuItem(
                        value: index,
                        child: Center(child: Text('linha_${index + 1}')),
                      );
                    }),
                    onChanged: (index) {
                      setState(
                        () => drawerStateController.setLineIndex(index!),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: screenWidth <= 1920 ? (drawerWidth * 0.4) : (drawerWidth * 0.2),
                        child: TextField(
                          controller: _spacingController,
                          inputFormatters: [
                            TextInputFormatter.withFunction((previousValue, attemptedValue) {

                              String attemptedText = attemptedValue.text;

                              // Regex para definir o limite de 2 números antes e depois do ponto
                              final allowedPattern = RegExp(r'^(\d{0,2})(\.\d{0,2})?$');

                              if (allowedPattern.hasMatch(attemptedText)) {
                                return attemptedValue;
                              } else {
                                return previousValue;
                              }
                            })
                          ],
                          cursorWidth: 4,
                          cursorRadius: const Radius.circular(8),
                          decoration: InputDecoration(
                            labelText: 'Espaçamento',
                            labelStyle: TextStyle(
                              color: AppPallete.grey500
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                      ),
                      TextButton.icon(
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Voltar'),
                        onPressed: () => {
                          _spacingController.clear(),
                          drawerStateController.reset()
                        }
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          Visibility(
            visible: drawerStateController.dropValue == 'Rank em Nível',
            child: ListTile(
              leading: Icon(
                Icons.park,
                color: AppPallete.green700
              ),
              title: Text(
                'Arvore',
                style: TextStyle(
                  color: AppPallete.white
                )
              ),
              tileColor: AppPallete.lightBlue,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: drawerStateController.radioValue == 'rank',
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            drawerStateController.decrementTreeCounter();
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            treeCounter.toString(),
                            style: AppTypography
                              .roboto
                              .bold
                              .base
                              .color
                              .white
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            drawerStateController.incrementTreeCounter();
                          },
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.pin_drop),
                    color: AppPallete.green700,
                    style: ButtonStyle(
                      overlayColor: WidgetStatePropertyAll(
                        AppPallete.transparent_05p
                      ),
                    ),

                    onPressed: () {
                      if (drawerStateController.selectedAreaIndex == -1) {
                        errorSnackBar(
                          context,
                          message: 'Por favor! Crie ou Selecione uma área primeiro',
                        );
                        return;
                      }

                      if (drawerStateController.radioValue != 'rank') {
                        treeController.addTreeToArea(
                          drawerStateController.selectedAreaIndex,
                        );
                        return;
                      }

                      treeController.addRankTreeToArea(
                        drawerStateController.selectedAreaIndex,
                        treeCounter,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: drawerStateController.dropValue == 'Rank Linear',
            child: ListTile(
              leading: Icon(
                Icons.park,
                color: AppPallete.green700
              ),
              title: Text(
                'Arvore',
                style: AppTypography
                  .roboto
                  .regular
                  .base
                  .color
                  .white
              ),
              tileColor: AppPallete.lightBlue,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.pin_drop),
                    color: AppPallete.green700,
                    style: ButtonStyle(
                      overlayColor: WidgetStatePropertyAll(
                        AppPallete.transparent_05p
                      ),
                    ),
                    onPressed: () {
                      if (drawerStateController.selectedLineIndex == -1) {
                        errorSnackBar(
                          context,
                          message: 'Por favor! Crie ou Selecione uma linha primeiro',
                        );
                        return;
                      }

                      final String spacingText = _spacingController.text;

                      if (spacingText.isEmpty) {
                        errorSnackBar(
                          context,
                          message: 'Por favor! Insira um valor para o espaçamento.',
                        );
                        return;
                      }

                      final spacing = double.tryParse(spacingText);

                      if ((spacing ?? 0) <= 0) {
                        errorSnackBar(
                          context,
                          message: 'Por favor! Insira um valor válido para o espaçamento'
                        );
                      }

                      treeController.addRankTreeToLine(
                        drawerStateController.selectedLineIndex,
                        spacing!,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
