import 'package:employee_app/utils/constants.dart';
import 'package:injectable/injectable.dart';
import 'package:fluttertoast/fluttertoast.dart';

@singleton
class ToastHelper {
  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: $constants.palette.green.withOpacity(0.75),
      textColor: $constants.palette.white,
      fontSize: 16.0,
    );
  }
}
