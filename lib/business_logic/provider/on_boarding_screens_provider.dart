import 'package:plant_app/exports/exports.dart';

class OnBoardingScreensProvider extends ChangeNotifier {
  int currentIndex = 0;

  final PageController pageController = PageController(initialPage: 0);
}
