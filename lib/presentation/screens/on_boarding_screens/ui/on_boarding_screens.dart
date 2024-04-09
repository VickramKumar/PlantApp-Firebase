// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:plant_app/exports/exports.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OnBoardingScreensProvider provider =
        Provider.of<OnBoardingScreensProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  onPageChanged: (int page) {
                    provider.currentIndex = page;
                    provider.notifyListeners();
                  },
                  controller: provider.pageController,
                  children: const [
                    CreatePage(
                      image: MyImages.first_plant,
                      title: 'Learn more about plants',
                      description:
                          'Read how to care for plants in our rich plants guide.',
                    ),
                    CreatePage(
                      image: MyImages.second_plant,
                      title: 'Find a plant lover friend',
                      description:
                          'Are you a plant lover? Connect with other plant lovers.',
                    ),
                    CreatePage(
                      image: MyImages.third_plant,
                      title: 'Plant a tree, green the Earth',
                      description:
                          'Find almost all types of plants that you like here.',
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    count: 3,
                    controller: provider.pageController,
                    effect: ExpandingDotsEffect(
                      dotHeight: 1.3.h,
                      dotWidth: 1.3.h,
                      spacing: 1.w,
                      activeDotColor: MyColors.appColor,
                    ),
                  ),
                  Container(
                    height: 6.h,
                    width: 6.h,
                    decoration: const BoxDecoration(
                      color: MyColors.appColor,
                      shape: BoxShape.circle,
                    ),
                    child: InkWell(
                      onTap: () {
                        if (provider.pageController.page == 2.0) {
                          Get.offAll(() => const LoginScreen());
                        } else {
                          provider.pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Center(
                        child: Icon(
                          Icons.keyboard_arrow_right_outlined,
                          size: 20.sp,
                          color: MyColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.5.h),
              Container(
                height: 5.h,
                decoration: BoxDecoration(
                  color: MyColors.appColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.sp),
                ),
                child: InkWell(
                  onTap: () {
                    Get.to(() => const LoginScreen());
                  },
                  child: Center(
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: MyColors.appColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}
