import 'package:plant_app/exports/exports.dart';

class ProfileWidget extends StatelessWidget {
  final IconData icon;
  final String title;

  const ProfileWidget({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.black.withOpacity(.5),
                size: 17.5.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.black.withOpacity(.4),
            size: 13.sp,
          )
        ],
      ),
    );
  }
}
