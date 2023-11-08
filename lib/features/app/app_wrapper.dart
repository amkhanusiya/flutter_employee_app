import 'package:auto_route/auto_route.dart';
import 'package:employee_app/blocs/blocs.dart';
import 'package:employee_app/modules/modules.dart';
import 'package:employee_app/utils/router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> with WidgetsBindingObserver {
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    Future.delayed(const Duration(milliseconds: 250), () {
      context.router.replace(const EmployeeListRoute());
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangePlatformBrightness() async {
    getIt<AppCubit>().updateSystemOverlay();
    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _key,
      child: const AutoRouter(),
    );
  }
}
