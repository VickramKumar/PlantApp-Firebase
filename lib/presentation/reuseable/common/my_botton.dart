// ignore_for_file: must_be_immutable

import 'package:plant_app/exports/exports.dart';

class MyButton extends StatelessWidget {
  String text;
  Function() onTap;

  double? height;
  double? width;
  double? borderRadius;
  bool? loading;
  Color? color;
  Color? textColor;
  Color? borderColor;

  MyButton({
    super.key,
    this.height,
    this.width,
    this.color,
    this.textColor,
    this.borderColor,
    this.borderRadius,
    this.loading = false,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: width ?? 100.w,
      height: height ?? 6.9.h,
      onPressed: onTap,
      highlightElevation: 0.5,
      color: color ?? MyColors.appColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 6.sp),
        side: BorderSide(
          color: borderColor ?? MyColors.transparent,
          width: 1.5,
        ),
      ),
      child: loading == true
          ? CustomLoadingIndicator()
          : Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: textColor ?? MyColors.white),
            ),
    );
  }
}
