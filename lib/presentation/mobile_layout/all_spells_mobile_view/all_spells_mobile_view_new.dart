import 'package:adventurers_parchment/data_sources/spells/spells_local_data_source.dart';
import 'package:adventurers_parchment/entities/spell_entity.dart';
import 'package:adventurers_parchment/presentation/common_widgets/selectable_list_widget.dart';
import 'package:adventurers_parchment/presentation/common_widgets/three_state_button_widget.dart';
import 'package:adventurers_parchment/presentation/mobile_layout/all_spells_mobile_view/all_spells_mobile_view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_widgets/spell_list_tile_widget/spell_list_tile_on_paper_widget.dart';
import 'all_spells_mobile_view_cubit.dart';

class AllSpellsMobileViewNew extends StatelessWidget {
  const AllSpellsMobileViewNew({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (context) => AllSpellsMobileViewCubit(
          SpellsLocalDataSource(),
        ),
        child: Column(
          children: [
            BlocBuilder<AllSpellsMobileViewCubit, AllSpellsMobileViewState>(
              builder: (context, state) {
                return Column(
                  children: [
                    ThreeStateButtonWidget(
                      onStateChanged: (currentState) =>
                          updateRequiresConcentration(context, currentState),
                      text: 'Concentration',
                    ),
                    SizedBox(height: 4),
                    ThreeStateButtonWidget(
                      onStateChanged: (currentState) =>
                          updateIsRitual(context, currentState),
                      text: 'Ritual',
                    ),
                    SizedBox(height: 4),
                    SelectableListWidget(
                      options: state.allFilterOptions.ranges,
                      onSelected: (selectedRanges) =>
                          updateSelectedRanges(context, selectedRanges),
                    ),
                    SizedBox(height: 4),
                    SelectableListWidget(
                      options: state.allFilterOptions.components
                          .map((e) => e.getString())
                          .toList(),
                      onSelected: (selectedComponents) =>
                          updateSelectedComponents(context, selectedComponents),
                    ),
                    SizedBox(height: 4),
                    SelectableListWidget(
                      options: state.allFilterOptions.characterClasses
                          .map((characterClass) => characterClass.name)
                          .toList(),
                      onSelected: (selectedCharacterClasses) =>
                          updateSelectedCharacterClasses(
                              context, selectedCharacterClasses),
                    ),
                    SizedBox(height: 4),
                    SelectableListWidget(
                      options: state.allFilterOptions.levels
                          .map((e) => e.toString())
                          .toList(),
                      onSelected: (selectedLevels) =>
                          updateSelectedLevels(context, selectedLevels),
                    ),
                    SizedBox(height: 4),
                    SelectableListWidget(
                      options: state.allFilterOptions.schools
                          .map((e) => e.name)
                          .toList(),
                      onSelected: (selectedSchools) =>
                          updateSelectedSchools(context, selectedSchools),
                    ),
                    SizedBox(height: 4),
                    SelectableListWidget(
                      options: state.allFilterOptions.durations,
                      onSelected: (durations) =>
                          updateSelectedDurations(context, durations),
                    ),
                    SizedBox(height: 4),
                    SelectableListWidget(
                      options: state.allFilterOptions.castingTimes,
                      onSelected: (selectedCastingTimes) =>
                          updateSelctedCastingTimes(
                              context, selectedCastingTimes),
                    ),
                  ],
                );
              },
            ),
            BlocBuilder<AllSpellsMobileViewCubit, AllSpellsMobileViewState>(
              builder: (context, state) => Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.filteredSpells.length,
                  itemBuilder: (context, index) => Align(
                    alignment: Alignment.center,
                    child: SpellListTileOnPaperWidget(
                      spell: state.filteredSpells[index],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  updateSelectedCharacterClasses(
          BuildContext context, List<String> selectedCharacterClasses) =>
      context
          .read<AllSpellsMobileViewCubit>()
          .updateSelectedCharacterClasses(selectedCharacterClasses);

  updateRequiresConcentration(BuildContext context, bool? currentState) {
    context
        .read<AllSpellsMobileViewCubit>()
        .updateRequiresConcentration(requiresConcentration: currentState);
  }

  updateSelectedSchools(BuildContext context, List<String> selectedSchools) {
    context.read<AllSpellsMobileViewCubit>().updateSelectedSchools(
          selectedSchools,
        );
  }

  updateSelectedLevels(BuildContext context, List<String> selectedLevels) {
    context.read<AllSpellsMobileViewCubit>().updateSelectedLevels(
          selectedLevels.map((e) => int.parse(e)).toList(),
        );
  }

  updateSelectedDurations(BuildContext context, List<String> durations) {
    context.read<AllSpellsMobileViewCubit>().updateSelectedDurations(durations);
  }

  updateSelctedCastingTimes(
      BuildContext context, List<String> selectedCastingTimes) {
    context
        .read<AllSpellsMobileViewCubit>()
        .updateSelectedCastingTimes(selectedCastingTimes);
  }

  updateSelectedRanges(BuildContext context, List<String> selectedRanges) {
    context
        .read<AllSpellsMobileViewCubit>()
        .updateSelectedRanges(selectedRanges);
  }

  void showSnackbarMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  updateIsRitual(BuildContext context, bool? currentState) {
    context
        .read<AllSpellsMobileViewCubit>()
        .updateIsRitual(isRitual: currentState);
  }

  updateSelectedComponents(
      BuildContext context, List<String> selectedComponentsNames) {
    context.read<AllSpellsMobileViewCubit>().updateSelectedComponents(
        spellComponentsNames: selectedComponentsNames);
  }
}
