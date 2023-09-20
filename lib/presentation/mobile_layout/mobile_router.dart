import 'package:dnd_app/presentation/large_layout/spell_details_view.dart';
import 'package:dnd_app/presentation/mobile_layout/all_spells_mobile_view.dart';
import 'package:dnd_app/presentation/mobile_layout/favorite_spells_mobile_view.dart';
import 'package:dnd_app/presentation/mobile_layout/main_menu_view.dart';
import 'package:dnd_app/presentation/mobile_layout/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    ShellRoute(
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => NoTransitionPage(
            child: MainMenuView(),
          ),
          // builder: (context, state) => MainMenuView(),
          routes: [
            GoRoute(
              path: 'spells/favorite',
              pageBuilder: (context, state) => NoTransitionPage(
                child: FavoriteSpellsMobileView(),
              ),
            ),
            GoRoute(
              path: 'spells',
              pageBuilder: (context, state) => NoTransitionPage(
                child: AllSpellsMobileView(),
              ),
              routes: [
                GoRoute(
                  path: ':spellId',
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: SpellDetailsView(
                      spellIndex: state.pathParameters['spellId']!,
                    ),
                  ),
                ),
              ],
            ),
            GoRoute(
              path: 'licenses',
              pageBuilder: (context, state) => NoTransitionPage(
                child: LicensePage(),
              ),
            ),
          ],
        ),
      ],
      builder: (context, state, child) => MainScaffold(
        child: child,
      ),
    )
  ],
);
