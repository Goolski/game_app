import 'dart:convert';

import 'package:dnd_app/entities/spell_entity.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const favoriteSpellsBox = 'favorite-spells';
const favoriteSpellsKey = 'fav-spells';

class FavoriteSpellsLocalDataSource {
  Future<void> addFavouriteSpell({required SpellEntity spell}) async {
    var spellSet = await getFavoriteSpells();
    spellSet.add(spell);

    await _updateFavoriteSpells(updatedSpells: spellSet);
  }

  Future<void> deleteFavoriteSpell({required SpellEntity spell}) async {
    var spellSet = await getFavoriteSpells();
    spellSet.removeWhere((element) => element.index == spell.index);

    await _updateFavoriteSpells(updatedSpells: spellSet);
  }

  Future<Set<SpellEntity>> getFavoriteSpells() async {
    final box = await Hive.openBox(favoriteSpellsBox);
    final spellsJson = await box.get(favoriteSpellsKey);
    box.close();
    if (spellsJson == null) {
      _initiateFavoriteSpells();
      return <SpellEntity>{};
    }
    final spells = _decodeSpells(spellsJson);
    return spells;
  }

  Future<Stream<Set<SpellEntity>>> getAllFavoriteSpellsStream() async {
    final box = await Hive.openBox(favoriteSpellsBox);
    return box.watch(key: favoriteSpellsKey).asyncMap(
          (event) => _decodeSpells(event.value),
        );
  }

  Future<void> _updateFavoriteSpells(
      {required Set<SpellEntity> updatedSpells}) async {
    final box = await Hive.openBox(favoriteSpellsBox);
    await box.put(favoriteSpellsKey, _encodeSpellsIntoJson(updatedSpells));
    await box.close();
  }

  Set<SpellEntity> _decodeSpells(String json) {
    return (jsonDecode(json) as List<Map<String, dynamic>>)
        .map((spell) => SpellEntity.fromJson(spell))
        .toSet();
  }

  String _encodeSpellsIntoJson(Set<SpellEntity> spells) {
    return jsonEncode(spells);
  }

  Future<void> _initiateFavoriteSpells() async {
    final box = await Hive.openBox(favoriteSpellsBox);
    box.put(favoriteSpellsKey, jsonEncode([]));
    box.close();
  }
}
