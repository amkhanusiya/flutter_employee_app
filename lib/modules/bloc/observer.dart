import 'package:employee_app/utils/methods/aliases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Observer extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    logIt.info('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    logIt
      ..info('onChange-current -- ${bloc.runtimeType}, ${change.currentState}')
      ..info('onChange-next -- ${bloc.runtimeType}, ${change.nextState}');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    logIt.error('onError -- ${bloc.runtimeType}, $error');
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    logIt.info('onClose -- ${bloc.runtimeType}');
  }
}
