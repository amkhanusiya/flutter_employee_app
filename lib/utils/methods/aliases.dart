import 'package:employee_app/models/env_model.dart';
import 'package:employee_app/modules/dependency_injection/di.dart';
import 'package:employee_app/utils/helpers/datetime_helper.dart';
import 'package:employee_app/utils/helpers/logging_helper.dart';
import 'package:employee_app/utils/helpers/toast_helper.dart';
import 'package:employee_app/utils/router.dart';

final LoggingHelper logIt = getIt<LoggingHelper>();
final DateTimeHelper dateTime = getIt<DateTimeHelper>();
final EnvModel env = getIt<EnvModel>();
final AppRouter appRouter = getIt<AppRouter>();
final ToastHelper toast = getIt<ToastHelper>();
