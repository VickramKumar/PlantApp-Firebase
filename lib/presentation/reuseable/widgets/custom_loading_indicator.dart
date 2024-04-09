// ignore_for_file: must_be_immutable

import 'package:plant_app/exports/exports.dart';

class CustomLoadingIndicator extends StatelessWidget {
  Color? color;
  double? strokeWidth;

  CustomLoadingIndicator({
    super.key,
    this.color,
    this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? MyColors.white,
        strokeWidth: strokeWidth ?? 2.5,
      ),
    );
  }
}
