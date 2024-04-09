// ignore_for_file: must_be_immutable

import 'package:plant_app/exports/exports.dart';

class NewPlantsTileWidget extends StatelessWidget {
  int index;
  String documentId;
  AsyncSnapshot snapshot;

  NewPlantsTileWidget({
    super.key,
    required this.index,
    required this.snapshot,
    required this.documentId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Get.to(
          () => PlantDetailsScreen(
            collection: 'new_plants',
            documentId: documentId,
          ),
        );
      },
      child: Container(
        height: 8.h,
        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.3.h),
        decoration: BoxDecoration(
          color: MyColors.appColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(7.sp),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: 7.h,
                  height: 7.h,
                  decoration: const BoxDecoration(
                    color: MyColors.appColor,
                    shape: BoxShape.circle,
                  ),
                ),
                Positioned(
                  bottom: 0.5.h,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 8.5.h,
                    child: Image.network(
                      snapshot.data!.docs[index]['image'],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 6.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  snapshot.data!.docs[index]['category'],
                  style: TextStyle(
                    color: MyColors.black54,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  snapshot.data!.docs[index]['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              r'$' + snapshot.data!.docs[index]['price'].toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
