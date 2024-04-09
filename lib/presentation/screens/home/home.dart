// ignore_for_file: must_be_immutable, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:plant_app/exports/exports.dart';

class Home extends StatelessWidget {
  UserModel? userModel;

  Home({
    super.key,
    this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    HomeProvider provider = Provider.of<HomeProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Selector<HomeProvider, int>(
              selector: (context, selector) => selector.bottomNavIndex,
              builder: (context, value, child) {
                return Text(
                  provider.titleList[provider.bottomNavIndex],
                  style: TextStyle(
                    color: MyColors.appColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                  ),
                );
              },
            ),
            Icon(
              Icons.notifications,
              color: MyColors.appColor,
              size: 22.sp,
            )
          ],
        ),
      ),
      body: Selector<HomeProvider, int>(
        selector: (context, selector) => selector.bottomNavIndex,
        builder: (context, value, child) {
          return IndexedStack(
            index: provider.bottomNavIndex,
            children: provider.screens(),
          );
        },
      ),
      bottomNavigationBar: Selector<HomeProvider, int>(
        selector: (context, selector) => selector.bottomNavIndex,
        builder: (context, value, child) {
          return BottomNavigationBar(
            elevation: 20,
            backgroundColor: MyColors.white,
            iconSize: 18.sp,
            selectedItemColor: MyColors.appColor,
            currentIndex: provider.bottomNavIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            onTap: provider.onTabChange,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_shopping_cart_sharp), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
            ],
          );
        },
      ),
    );
  }
}
