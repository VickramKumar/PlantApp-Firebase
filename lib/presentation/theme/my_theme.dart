import 'package:plant_app/exports/exports.dart';

class MyTheme {
  static ThemeData theme() {
    return ThemeData(
      scaffoldBackgroundColor: MyColors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: MyColors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: MyColors.white,
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      iconTheme: IconThemeData(color: MyColors.white, size: 17.sp),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: MyColors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(200.h),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.11,
            color: MyColors.blue,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: MyColors.fontGrey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: MyColors.fontGrey,
          ),
        ),
      ),
    );
  }
}
