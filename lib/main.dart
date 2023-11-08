import 'dart:async';

import 'package:employee_app/blocs/blocs.dart';
import 'package:employee_app/features/features.dart';
import 'package:employee_app/models/models.dart';
import 'package:employee_app/modules/dependency_injection/di.dart';
import 'package:employee_app/utils/helpers/logging_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'i18n/strings.g.dart';
import 'modules/bloc/observer.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Use device locale.
      LocaleSettings.useDeviceLocale();

      // Configures dependency injection to init modules and singletons.
      await configureDependencyInjection();

      // Sets system overlay style.
      await SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [
          SystemUiOverlay.top,
          SystemUiOverlay.bottom,
        ],
      );

      Bloc.observer = Observer();

      await Hive.initFlutter();
      Hive.registerAdapter(EmployeeAdapter());

      return runApp(
        TranslationProvider(
          child: FlutterSizer(
            builder: (context, orientation, screenType) => const App(),
          ),
        ),
      );
    },
    (exception, stackTrace) async {
      LoggingHelper().wtf("Something went wrong!!",
          error: exception, stackTrace: stackTrace);
    },
  );
}
