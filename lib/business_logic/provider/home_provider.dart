import 'package:plant_app/exports/exports.dart';

class HomeProvider extends ChangeNotifier {
  int bottomNavIndex = 0;

  List<Widget> screens() {
    return [
      const HomeScreen(),
      const FavoriteScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];
  }

  List<String> titleList = [
    'Home',
    'Favorite',
    'Cart',
    'Profile',
  ];

  void onTabChange(index) {
    bottomNavIndex = index;
    notifyListeners();
  }
}
