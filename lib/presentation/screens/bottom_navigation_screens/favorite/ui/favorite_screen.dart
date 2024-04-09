import 'package:plant_app/exports/exports.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('favorite')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CustomLoadingIndicator();
          } else {
            if (snapshot.data!.docs.isEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 100.w),
                  SizedBox(
                    height: 14.h,
                    child: Image.asset(MyImages.favorite),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    'Your Favorite Plants will be Shown here...',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              );
            } else {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Column(
                  children: [
                    ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 1.h),
                          decoration: BoxDecoration(
                            color: MyColors.appColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(7.sp),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: NewPlantsTileWidget(
                                  index: index,
                                  documentId: snapshot.data!.docs[index]
                                      ['doc_id'],
                                  snapshot: snapshot,
                                ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(7.sp),
                                onTap: () async {
                                  List<dynamic> favoriteList =
                                      snapshot.data!.docs[index]['is_favorite'];

                                  favoriteList.remove(
                                      FirebaseAuth.instance.currentUser!.uid);

                                  await FirebaseFirestore.instance
                                      .collection(snapshot.data!.docs[index]
                                          ['collection'])
                                      .doc(snapshot.data!.docs[index]['doc_id'])
                                      .update(
                                    {
                                      'is_favorite': favoriteList,
                                    },
                                  );

                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .collection('favorite')
                                      .doc(snapshot.data!.docs[index]['doc_id'])
                                      .delete();
                                },
                                child: Container(
                                  height: 8.h,
                                  width: 15.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(7.sp),
                                      bottomRight: Radius.circular(7.sp),
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.delete,
                                      size: 17.sp,
                                      color: MyColors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 3.w),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}
