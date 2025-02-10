import 'package:fluttertoast/fluttertoast.dart';

class AppFunctions{
  static showSimpleToastMessage({required String msg}) async{
    await Fluttertoast.showToast(msg: msg);
  }

}