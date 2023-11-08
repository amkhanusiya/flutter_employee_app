import 'package:employee_app/modules/dependency_injection/di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  preferRelativeImports: false,
)
Future<GetIt> configureDependencyInjection() async => getIt.init();
