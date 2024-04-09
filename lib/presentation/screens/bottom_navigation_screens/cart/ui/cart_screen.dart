import 'package:plant_app/exports/exports.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CartScreenProvider provider =
        Provider.of<CartScreenProvider>(context, listen: false);

    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('cart')
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
                    child: Image.asset(MyImages.addCart),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    'Your Cart is Empty.',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              );
            } else {
              provider.totalPrice = 0;

              for (var i = 0; i < snapshot.data!.docs.length; i++) {
                provider.totalPrice =
                    provider.totalPrice + snapshot.data!.docs[i]['price'];
              }

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
                                  List<dynamic> cartList = snapshot
                                      .data!.docs[index]['is_added_to_cart'];

                                  cartList.remove(
                                      FirebaseAuth.instance.currentUser!.uid);

                                  await FirebaseFirestore.instance
                                      .collection(snapshot.data!.docs[index]
                                          ['collection'])
                                      .doc(snapshot.data!.docs[index]['doc_id'])
                                      .update(
                                    {
                                      'is_added_to_cart': cartList,
                                    },
                                  );

                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .collection('cart')
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
                    const Spacer(),
                    Container(
                      height: 6.h,
                      width: 100.w,
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      decoration: BoxDecoration(
                        color: MyColors.appColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(7.sp),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount:',
                            style: TextStyle(
                              color: MyColors.black,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '\$${provider.totalPrice}',
                            style: TextStyle(
                              color: MyColors.appColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
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
