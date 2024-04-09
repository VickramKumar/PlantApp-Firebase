// ignore_for_file: must_be_immutable

import 'package:plant_app/exports/exports.dart';

class PlantDetailsScreen extends StatelessWidget {
  String documentId;
  String collection;

  PlantDetailsScreen({
    super.key,
    required this.documentId,
    required this.collection,
  });

  @override
  Widget build(BuildContext context) {
    HomeScreenProvider provider =
        Provider.of<HomeScreenProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(collection)
              .where('doc_id', isEqualTo: documentId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CustomLoadingIndicator();
            } else {
              return Stack(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 5.h,
                            width: 5.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: MyColors.appColor.withOpacity(.15),
                            ),
                            child: const Icon(
                              Icons.close,
                              color: MyColors.appColor,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            provider.addOrRemovePlantFromFavorite(
                              collection,
                              snapshot,
                              0,
                            );
                          },
                          child: Container(
                            height: 5.h,
                            width: 5.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: MyColors.appColor.withOpacity(.15),
                            ),
                            child: Icon(
                              snapshot.data!.docs[0]['is_favorite'].contains(
                                      FirebaseAuth.instance.currentUser!.uid)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: MyColors.appColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 100.h, width: 100.w),
                  Positioned(
                    top: 12.h,
                    left: 7.w,
                    right: 0.w,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 43.h,
                          width: 50.w,
                          child: Image.network(
                            snapshot.data!.docs[0]['image'],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Size',
                              style: TextStyle(
                                color: MyColors.black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              snapshot.data!.docs[0]['size'],
                              style: TextStyle(
                                color: MyColors.appColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 1.5.h),
                            Text(
                              'Humidity',
                              style: TextStyle(
                                color: MyColors.black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              snapshot.data!.docs[0]['humidity'].toString(),
                              style: TextStyle(
                                color: MyColors.appColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 1.5.h),
                            Text(
                              'Temperature',
                              style: TextStyle(
                                color: MyColors.black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              snapshot.data!.docs[0]['temperature'],
                              style: TextStyle(
                                color: MyColors.appColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 1.5.h),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 51.h,
                      width: 100.w,
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      decoration: BoxDecoration(
                        color: MyColors.appColor.withOpacity(.25),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(27.sp),
                          topLeft: Radius.circular(27.sp),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.5.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                snapshot.data!.docs[0]['name'],
                                style: TextStyle(
                                  color: MyColors.appColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17.sp,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                snapshot.data!.docs[0]['rating'].toString(),
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w500,
                                  color: MyColors.appColor,
                                ),
                              ),
                              Icon(
                                Icons.star,
                                size: 20.sp,
                                color: MyColors.appColor,
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Description:',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: MyColors.appColor,
                            ),
                          ),
                          Text(
                            snapshot.data!.docs[0]['description'],
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: MyColors.black.withOpacity(.7),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              StatefulBuilder(builder: (context, setState) {
                                return Container(
                                  height: 5.7.h,
                                  width: 5.7.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: snapshot
                                            .data!.docs[0]['is_added_to_cart']
                                            .contains(FirebaseAuth
                                                .instance.currentUser!.uid)
                                        ? MyColors.white
                                        : MyColors.appColor.withOpacity(.5),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(0, 1),
                                        blurRadius: 5,
                                        color:
                                            MyColors.appColor.withOpacity(.3),
                                      ),
                                    ],
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(100.w),
                                    onTap: () async {
                                      provider.addOrRemovePlantFromCart(
                                        collection,
                                        snapshot,
                                      );

                                      setState(() {});
                                    },
                                    child: Builder(
                                      builder: (context) {
                                        if (snapshot
                                            .data!.docs[0]['is_added_to_cart']
                                            .contains(FirebaseAuth
                                                .instance.currentUser!.uid)) {
                                          return const Icon(
                                            Icons.remove_shopping_cart,
                                            color: MyColors.appColor,
                                          );
                                        } else {
                                          return const Icon(
                                            Icons.shopping_cart,
                                            color: MyColors.white,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                );
                              }),
                              SizedBox(width: 5.w),
                              Expanded(
                                child: MyButton(
                                  text: 'BUY NOW',
                                  height: 5.7.h,
                                  borderRadius: 10.sp,
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
