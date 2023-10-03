import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data_sources/spells/spells_remote_data_source.dart';
import '../../../di/di.dart';
import '../../../entities/spell_entity.dart';
import '../../common_widgets/spell_list_tile_widget/spell_list_tile_on_paper_widget.dart';

class AllSpellsView extends StatelessWidget {
  const AllSpellsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => AllSpellsViewController(
          (message) => showSnackbarMessage(message, context),
        ),
        child: Consumer<AllSpellsViewController>(
          builder: (context, controller, child) {
            switch (controller.spells.isNotEmpty) {
              case true:
                return ListView.builder(
                  itemCount: controller.spells.length,
                  itemBuilder: (context, index) => SpellListTileOnPaperWidget(
                    spell: controller.spells[index],
                  ),
                );
              case false:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ),
      ),
    );
  }

  void showSnackbarMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

class AllSpellsViewController extends ChangeNotifier {
  AllSpellsViewController(this.showErrorMessage) {
    _init();
  }

  Function(String) showErrorMessage;

  List<SpellEntity> _spells = [];
  List<SpellEntity> get spells => _spells;

  final SpellsRemoteDataSource _spellsDataSource =
      Injector.resolve<SpellsRemoteDataSource>();

  Future<void> _init() async {
    try {
      await getSpells();
    } catch (e) {
      showErrorMessage('Error');
    }
  }

  Future<void> getSpells() async {
    final newSpells = await _spellsDataSource.getSpells();
    _spells = newSpells;
    notifyListeners();
  }
}
