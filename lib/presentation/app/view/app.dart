// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_app/common/injector/injector.dart';
import 'package:movie_app/common/l10n/l10n.dart';
import 'package:movie_app/presentation/dashboard/cubit/dashboard_cubit.dart';
import 'package:movie_app/presentation/dashboard/view/dashboard_page.dart';
import 'package:movie_app/presentation/details/cubit/details_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => Injector.resolve!<DashboardCubit>(),
        ),
        BlocProvider(
          create: (_) => Injector.resolve!<DetailsCubit>(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Colors.teal),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: const Color(0xFF13B9FF),
          ),
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        initialRoute: '/dashboard',
        routes: {
          '/dashboard': (context) => const DashboardPage()
        },
      ),
    );
  }
}
