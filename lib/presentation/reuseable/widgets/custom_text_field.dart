// // ignore_for_file: must_be_immutable

// import 'package:plant_app/exports/exports.dart';

// class CustomTextfield extends StatelessWidget {
//   String hintText;
//   IconData icon;
//   TextEditingController controller;

//   bool? obscureText;

//   CustomTextfield({
//     super.key,
//     this.obscureText,
//     required this.icon,
//     required this.hintText,
//     required this.controller,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       obscureText: obscureText ?? false,
//       cursorColor: MyColors.black54.withOpacity(.5),
//       style: TextStyle(
//         color: MyColors.black,
//         fontSize: 12.sp,
//         fontWeight: FontWeight.w400,
//       ),
//       decoration: InputDecoration(
//         hintText: hintText,
//         hintStyle: TextStyle(
//           color: MyColors.black54,
//           fontSize: 12.sp,
//           fontWeight: FontWeight.w400,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(7.sp),
//         ),
//         prefixIcon: Icon(
//           icon,
//           color: MyColors.black54.withOpacity(.3),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: must_be_immutable

import 'package:plant_app/exports/exports.dart';

class CustomTextField extends StatelessWidget {
  String hintText;
  IconData icon;
  TextEditingController controller;

  int? maxLines;
  bool? obscureText;
  bool? readOnly;
  IconData? suffixIcon;
  Function()? onTap;
  Function()? suffixOnPressed;

  CustomTextField({
    super.key,
    this.onTap,
    this.readOnly,
    this.maxLines,
    this.suffixIcon,
    this.obscureText,
    this.suffixOnPressed,
    required this.icon,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly ?? false,
      obscureText: obscureText ?? false,
      maxLines: maxLines ?? 1,
      onTap: onTap ?? () {},
      cursorColor: MyColors.black54.withOpacity(.5),
      style: TextStyle(
        color: MyColors.black,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(
          icon,
          color: MyColors.black54.withOpacity(.3),
          size: 16.sp,
        ),
        hintStyle: TextStyle(
          color: MyColors.black54,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.sp),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
        suffixIcon: Visibility(
          visible: suffixIcon != null,
          child: IconButton(
            icon: Icon(
              suffixIcon,
              color: MyColors.black,
              size: 16.sp,
            ),
            onPressed: suffixOnPressed ?? () {},
          ),
        ),
      ),
    );
  }
}
