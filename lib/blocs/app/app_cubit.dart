import 'package:employee_app/models/models.dart';
import 'package:employee_app/modules/dependency_injection/di.dart';
import 'package:employee_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'app_cubit.freezed.dart';

part 'app_state.dart';

@lazySingleton
class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState.initial());

  void updateSystemOverlay() {
    final systemModeIsDark =
        SchedulerBinding.instance.window.platformBrightness == Brightness.dark;

    final isDark = state.theme.mode == ThemeMode.system
        ? systemModeIsDark
        : state.theme.mode == ThemeMode.dark;
    final colorScheme =
        isDark ? state.theme.dark.colorScheme : state.theme.light.colorScheme;
    final primaryColor = ElevationOverlay.colorWithOverlay(
        colorScheme.surface, colorScheme.primary, 3);

    SystemChrome.setSystemUIOverlayStyle(
      createOverlayStyle(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primaryColor: primaryColor,
      ),
    );
  }
}
