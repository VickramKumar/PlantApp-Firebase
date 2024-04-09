// ignore_for_file: must_be_immutable

import 'package:plant_app/exports/exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Future.delayed(const Duration(milliseconds: 1000));
  FlutterNativeSplash.remove();

  UserModel? userModel;

  User? currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser != null) {
    userModel = await FirebaseHelper.getUserDataById(currentUser.uid);

    runApp(MyApp(screen: Home(userModel: userModel)));
  } else {
    runApp(MyApp(screen: const OnboardingScreen()));
  }
}

class MyApp extends StatelessWidget {
  Widget? screen;

  MyApp({
    super.key,
    this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => CartScreenProvider()),
        ChangeNotifierProvider(create: (context) => HomeScreenProvider()),
        ChangeNotifierProvider(create: (context) => LoginScreenProvider()),
        ChangeNotifierProvider(create: (context) => SignUpScreenProvider()),
        ChangeNotifierProvider(create: (context) => ProfileScreenProvider()),
        ChangeNotifierProvider(
            create: (context) => OnBoardingScreensProvider()),
      ],
      builder: (context, child) {
        return Sizer(
          builder: (context, orientation, device) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              home: screen,
            );
          },
        );
      },
    );
  }
}
