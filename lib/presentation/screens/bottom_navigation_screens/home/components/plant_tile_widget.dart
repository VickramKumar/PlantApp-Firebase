// ignore_for_file: must_be_immutable

import 'package:plant_app/exports/exports.dart';

class PlantTileWidget extends StatelessWidget {
  int index;
  String documentId;
  AsyncSnapshot snapshot;

  PlantTileWidget({
    super.key,
    required this.index,
    required this.snapshot,
    required this.documentId,
  });

  @override
  Widget build(BuildContext context) {
    HomeScreenProvider provider =
        Provider.of<HomeScreenProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        Get.to(
          () => PlantDetailsScreen(
            collection: 'plants',
            documentId: documentId,
          ),
        );
      },
      child: Container(
        width: 51.w,
        margin: EdgeInsets.only(
          left: 3.w,
          right: index == snapshot.data!.docs.length - 1 ? 3.w : 0.w,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 2.7.w,
          vertical: 2.7.w,
        ),
        decoration: BoxDecoration(
          color: MyColors.appColor.withOpacity(.8),
          borderRadius: BorderRadius.circular(15.sp),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                borderRadius: BorderRadius.circular(200.h),
                onTap: () async {
                  provider.addOrRemovePlantFromFavorite(
                    'plants',
                    snapshot,
                    index,
                  );
                },
                child: Container(
                  height: 4.h,
                  width: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Builder(
                      builder: (context) {
                        if (snapshot.data!.docs[index]['is_favorite']
                            .contains(FirebaseAuth.instance.currentUser!.uid)) {
                          return Icon(
                            Icons.favorite,
                            color: MyColors.appColor,
                            size: 16.sp,
                          );
                        } else {
                          return Icon(
                            Icons.favorite_border,
                            color: MyColors.appColor,
                            size: 16.sp,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 22.h,
              width: 52.w,
              child: Image.network(
                snapshot.data!.docs[index]['image'],
              ),
            ),
            SizedBox(height: 1.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      snapshot.data!.docs[index]['category'],
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10.5.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      snapshot.data!.docs[index]['name'],
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10.5.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.5.w,
                    vertical: 0.3.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    r'$' + snapshot.data!.docs[index]['price'].toString(),
                    style: TextStyle(
                      color: MyColors.appColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
