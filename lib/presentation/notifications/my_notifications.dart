import 'package:another_flushbar/flushbar.dart';
import 'package:plant_app/exports/exports.dart';

class MyNotifications {
  static flushbar({
    IconData? icon,
    required BuildContext context,
    required String message,
  }) async {
    await Flushbar(
      positionOffset: 3.h,
      duration: const Duration(seconds: 3),
      flushbarStyle: FlushbarStyle.FLOATING,
      leftBarIndicatorColor: MyColors.appColor,
      icon: Icon(icon ?? Icons.error_outline, color: MyColors.appColor),
      backgroundColor: MyColors.appColor.withOpacity(0.5),
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 3.w),
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.w),
      messageText: Text(
        message,
        style: TextStyle(
          color: MyColors.black,
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    ).show(context);
  }
}
