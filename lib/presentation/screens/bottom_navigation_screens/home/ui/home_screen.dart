// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:plant_app/exports/exports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeScreenProvider provider =
        Provider.of<HomeScreenProvider>(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 6.h,
              width: 100.w,
              padding: EdgeInsets.only(left: 4.w, right: 1.3.w),
              margin: EdgeInsets.symmetric(horizontal: 2.w),
              decoration: BoxDecoration(
                color: MyColors.appColor.withOpacity(.1),
                borderRadius: BorderRadius.circular(200.h),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Icon(
                      Icons.search,
                      size: 15.sp,
                      color: Colors.black54.withOpacity(.6),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 0.3.h),
                      child: Center(
                        child: TextFormField(
                          controller: provider.searchController,
                          onChanged: (value) {
                            provider.notifyListeners();
                          },
                          decoration: const InputDecoration(
                            hintText: 'Search Plant',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Selector<HomeScreenProvider, String>(
                    selector: (context, selector) =>
                        selector.searchController.text,
                    builder: (context, searchValue, child) {
                      if (searchValue.isEmpty) {
                        return Selector<HomeScreenProvider, bool>(
                          selector: (context, selector) =>
                              selector.isRecordingVoice,
                          builder: (context, value, child) {
                            return GestureDetector(
                              onTapUp: (details) {
                                provider.isRecordingVoice = false;
                                provider.notifyListeners();
                              },
                              onTapDown: (details) async {
                                provider.isRecordingVoice = true;
                                provider.notifyListeners();

                                bool available =
                                    await provider.speechToText.initialize();

                                if (available) {
                                  provider.speechToText.listen(
                                    onResult: (value) {
                                      provider.searchController.text =
                                          value.recognizedWords;
                                      provider.notifyListeners();
                                    },
                                  );
                                } else {
                                  provider.searchController.text =
                                      'It is not recording voice';
                                  provider.notifyListeners();
                                }
                              },
                              child: AvatarGlow(
                                animate: value,
                                glowRadiusFactor: 0.2,
                                glowColor: MyColors.appColor.withOpacity(0.5),
                                child: SizedBox(
                                  height: 5.h,
                                  width: 5.h,
                                  child: Icon(
                                    Icons.mic,
                                    size: 15.sp,
                                    color: MyColors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Padding(
                          padding: EdgeInsets.only(right: 2.w),
                          child: InkWell(
                            onTap: () {
                              provider.searchController.clear();
                              provider.notifyListeners();
                            },
                            child: Center(
                              child: Icon(
                                Icons.cancel,
                                size: 16.sp,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.8.h),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Selector<HomeScreenProvider, String>(
                selector: (context, selector) => selector.plantsCategory,
                builder: (context, value, child) {
                  return Row(
                    children: List.generate(
                      provider.plantsCategoryList.length,
                      (index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 3.w),
                          child: GestureDetector(
                            onTap: () {
                              provider.plantsCategory =
                                  provider.plantsCategoryList[index];
                              provider.notifyListeners();
                            },
                            child: Builder(
                              builder: (context) {
                                if (provider.plantsCategory ==
                                    provider.plantsCategoryList[index]) {
                                  return Text(
                                    provider.plantsCategoryList[index],
                                    style: TextStyle(
                                      fontSize: 12.5.sp,
                                      fontWeight: FontWeight.w500,
                                      color: MyColors.appColor,
                                    ),
                                  );
                                } else {
                                  return Text(
                                    provider.plantsCategoryList[index],
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w300,
                                      color: MyColors.black,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 1.2.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Selector<HomeScreenProvider, String>(
                selector: (context, selector) => selector.plantsCategory,
                builder: (context, value, child) {
                  return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('plants')
                        .where('category', isEqualTo: provider.plantsCategory)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CustomLoadingIndicator(color: MyColors.black);
                      } else {
                        if (snapshot.data!.docs.isEmpty) {
                          return SizedBox(
                            height: 30.3.h,
                            width: 100.w,
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'No Results found in the category ',
                                      style: TextStyle(
                                        color: MyColors.black,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextSpan(
                                      text: provider.plantsCategory,
                                      style: TextStyle(
                                        color: MyColors.appColor,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        return Selector<HomeScreenProvider, String>(
                          selector: (context, selector) =>
                              selector.searchController.text,
                          builder: (context, value, child) {
                            return Row(
                              children: List.generate(
                                snapshot.data!.docs.length,
                                (index) {
                                  if (provider
                                      .searchController.text.isNotEmpty) {
                                    if (snapshot.data!.docs[index]['name']
                                        .toLowerCase()
                                        .contains(provider.searchController.text
                                            .toLowerCase())) {
                                      return PlantTileWidget(
                                        index: index,
                                        snapshot: snapshot,
                                        documentId: snapshot.data!.docs[index]
                                            ['doc_id'],
                                      );
                                    } else {
                                      return const Center();
                                    }
                                  } else {
                                    return PlantTileWidget(
                                      index: index,
                                      snapshot: snapshot,
                                      documentId: snapshot.data!.docs[index]
                                          ['doc_id'],
                                    );
                                  }
                                },
                              ),
                            );
                          },
                        );
                      }
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.only(left: 4.w),
              child: Text(
                'New Plants',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                ),
              ),
            ),
            SizedBox(height: 1.5.h),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('new_plants')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CustomLoadingIndicator(color: MyColors.black);
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left: 3.w,
                          right: 3.w,
                          bottom: 1.3.h,
                        ),
                        child: NewPlantsTileWidget(
                          index: index,
                          snapshot: snapshot,
                          documentId: snapshot.data!.docs[index]['doc_id'],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
