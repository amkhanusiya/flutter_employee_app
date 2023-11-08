import 'package:auto_route/auto_route.dart';
import 'package:employee_app/blocs/blocs.dart';
import 'package:employee_app/i18n/strings.g.dart';
import 'package:employee_app/modules/dependency_injection/di.dart';
import 'package:employee_app/utils/constants.dart';
import 'package:employee_app/utils/methods/aliases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AppCubit>(),
      child: BlocBuilder<AppCubit, AppState>(
        buildWhen: (p, c) => p.theme != c.theme,
        builder: (context, state) {
          return MaterialApp.router(
            /// Theme configuration.
            theme: state.theme.light,

            /// Environment configuration.
            title: $constants.appTitle,
            debugShowCheckedModeBanner: env.debugShowCheckedModeBanner,
            debugShowMaterialGrid: env.debugShowMaterialGrid,

            /// AutoRouter configuration.
            routerDelegate: AutoRouterDelegate(
              appRouter,
            ),
            routeInformationParser: appRouter.defaultRouteParser(),

            /// EasyLocalization configuration.
            locale: TranslationProvider.of(context).flutterLocale,
            supportedLocales: LocaleSettings.supportedLocales,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}
