import 'package:flutter/material.dart' hide DropdownMenu;
import 'package:agro_sync/controllers/drawer_state_controller.dart';
import 'package:agro_sync/controllers/line_controller.dart';

import 'package:provider/provider.dart';
import 'package:agro_sync/controllers/tree_controller.dart';

import 'package:agro_sync/controllers/area_controller.dart';

import 'package:agro_sync/widgets/app_snackbars.dart';

import 'package:agro_sync/widgets/dropdown_menu.dart';

class AppDrawer extends StatefulWidget {

  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {

  late AreaController areaController;
  late TreeController treeController;
  late LineController lineController;

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();

    treeController = Provider.of<TreeController>(context);
    lineController = Provider.of<LineController>(context);
    areaController = treeController.areaController;
  }

  @override
  Widget build(BuildContext context) {

    final drawerStateController = context.watch<DrawerStateController>();
    int treeCounter = drawerStateController.treeCounter;

    return Drawer(
      width: (MediaQuery.of(context).size.width * 0.3),
      backgroundColor: Colors.grey.shade300,
      child: ListView(
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            decoration: const BoxDecoration(color: Colors.lightBlue),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: drawerStateController.dropValue.isEmpty,
                  child: DropdownMenu<String>(
                    value: (drawerStateController.dropValue.isEmpty) ? null : drawerStateController.dropValue,
                    hintText: 'Selecione o tipo de rank',
                    onChanged: (op) => drawerStateController.setDropValue(op.toString()),
                    items: drawerStateController.dropOptions
                      .map((op) => DropdownMenuItem(
                        value: op,
                        child: Center(
                          child: Text(op),
                        ),
                      ))
                      .toList()
                  )
                ),
                Visibility(
                  visible: drawerStateController.dropValue == 'Rank em Nível',
                  child: Column(
                    children: [
                      DropdownMenu<int>(
                        value: drawerStateController.selectedAreaIndex == -1 ? null : drawerStateController.selectedAreaIndex,
                        hintText: 'Selecione uma área',
                        items: List.generate(areaController.allAreas.length, (index) {
                          return DropdownMenuItem(
                            value: index,
                            child: Center(
                              child: Text(
                                'area_${index + 1}'
                              ),
                            ),
                          );
                        }),
                        onChanged: (index) {
                          setState(() => drawerStateController.setAreaIndex(index!));
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: drawerStateController.radioOptions.map((op) {
                                return Row(
                                  children: [
                                    Radio<String>(
                                      value: op,
                                      groupValue: drawerStateController.radioValue,
                                      visualDensity: VisualDensity.compact,
                                      fillColor: const WidgetStatePropertyAll(Colors.white),
                                      onChanged: (value) => drawerStateController.setRadioValue(value!)
                                    ),
                                    Text(
                                      op,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                  ]
                                );
                              }).toList()
                            ),
                          ),
                          TextButton.icon(
                            icon: const Icon(Icons.arrow_back),
                            label: const Text('Voltar'),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              textStyle: const TextStyle(fontSize: 16)
                            ),
                            onPressed: () => drawerStateController.reset(),
                          )
                        ]
                      ),
                    ],
                  ),
                ),

                if (drawerStateController.dropValue == 'Rank Linear') ...[
                  DropdownMenu<int>(
                    value: drawerStateController.selectedLineIndex == -1 ? null : drawerStateController.selectedLineIndex,
                    hintText: 'Selecione uma linha',
                    items: List.generate(lineController.allLines.length, (index) {
                      return DropdownMenuItem(
                        value: index,
                        child: Center(
                          child: Text(
                            'linha_${index + 1}'
                          ),
                        ),
                      );
                    }),
                    onChanged: (index) {
                      setState(() => drawerStateController.setLineIndex(index!));
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Voltar'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(fontSize: 16)
                        ),
                        onPressed: () => drawerStateController.reset(),
                      )
                    ],
                  )
                ]
              ],
            ),
          ),
          Visibility(
            visible: drawerStateController.dropValue == 'Rank em Nível',
            child: ListTile(
              leading: Icon(
                Icons.park,
                color: Colors.green.shade700
              ),
              title: const Text(
                'Arvore',
                style: TextStyle(
                  color: Colors.white
                )
              ),
              tileColor: Colors.lightBlue,
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
                          color: Colors.white,
                          onPressed: () {
                            drawerStateController.decrementTreeCounter();
                          }
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            treeCounter.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            )
                          )
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          color: Colors.white,
                          onPressed: () {
                            drawerStateController.incrementTreeCounter();
                          }
                        )
                      ]
                    )
                  ),
                  IconButton(
                    icon: const Icon(Icons.pin_drop),
                    color: Colors.green.shade700,
                    style: ButtonStyle(
                      overlayColor: WidgetStatePropertyAll(Colors.transparent.withValues(alpha: 0.05))
                    ),

                    onPressed: () {

                      if (drawerStateController.selectedAreaIndex == -1) {
                        errorSnackBar(
                          context,
                          message: 'Por favor! Crie ou Selecione uma área primeiro'
                        );
                        return;
                      }

                      if (drawerStateController.radioValue != 'rank') {
                        treeController.addTreeToArea(drawerStateController.selectedAreaIndex);
                        return;
                      }

                      treeController.addRankTreeToArea(drawerStateController.selectedAreaIndex, treeCounter);
                    }
                  )
                ]
              )
            )
          ),
          Visibility(
            visible: drawerStateController.dropValue == 'Rank Linear',
            child: ListTile(
              leading: Icon(
                Icons.park,
                color: Colors.green.shade700
              ),
              title: const Text(
                'Arvore',
                style: TextStyle(
                  color: Colors.white
                )
              ),
              tileColor: Colors.lightBlue,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  IconButton(
                    icon: const Icon(Icons.remove),
                    color: Colors.white,
                    onPressed: () {
                      drawerStateController.decrementTreeCounter();
                    }
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      treeCounter.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      )
                    )
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    color: Colors.white,
                    onPressed: () {
                      drawerStateController.incrementTreeCounter();
                    }
                  ),

                  IconButton(
                    icon: const Icon(Icons.pin_drop),
                    color: Colors.green.shade700,
                    style: ButtonStyle(
                      overlayColor: WidgetStatePropertyAll(Colors.transparent.withValues(alpha: 0.05))
                    ),

                    onPressed: () {

                      if (drawerStateController.selectedLineIndex == -1) {
                        errorSnackBar(
                          context,
                          message: 'Por favor! Crie ou Selecione uma linha primeiro'
                        );
                        return;
                      }

                      treeController.addRankTreeToLine(drawerStateController.selectedLineIndex, treeCounter);
                    }
                  )
                ]
              )
            ),
          )
        ],
      )
    );
  }
}