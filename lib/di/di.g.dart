// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'di.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void configureGenerated() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => CharactersCubit(c<CharactersLocalDataSource>()))
      ..registerFactory((c) =>
          AddSpellToCharactersWidgetCubit(c<CharactersLocalDataSource>()))
      ..registerFactory(
          (c) => CreateCharacterCubit(c<CharactersLocalDataSource>()))
      ..registerFactory((c) => CharactersLocalDataSource())
      ..registerFactory<SpellsDataSource>((c) => SpellsLocalDataSource());
  }
}
