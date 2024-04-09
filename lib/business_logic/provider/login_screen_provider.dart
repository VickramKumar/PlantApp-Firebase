import 'package:plant_app/exports/exports.dart';

class LoginScreenProvider extends ChangeNotifier {
  bool loading = false;

  bool obscureText = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  clearControllers() {
    emailController.clear();
    passwordController.clear();
  }

  login(context) {
    if (emailController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty) {
      loading = true;
      notifyListeners();

      firebaseAuth
          .signInWithEmailAndPassword(
        email: emailController.text.trim().toString(),
        password: passwordController.text.trim().toString(),
      )
          .then(
        (value) async {
          loading = false;
          notifyListeners();

          UserModel? userModel = await FirebaseHelper.getUserDataById(
              FirebaseAuth.instance.currentUser!.uid);

          Get.offAll(() => Home(userModel: userModel));

          MyNotifications.flushbar(
            context: context,
            message: 'You\'ve Logged In Successfuly...☺',
            icon: Icons.sentiment_satisfied,
          );

          emailController.clear();
          passwordController.clear();
        },
      ).onError(
        (error, stackTrace) {
          loading = false;
          notifyListeners();

          MyNotifications.flushbar(context: context, message: error.toString());
        },
      );
    } else if (emailController.text.trim().isEmpty &&
        passwordController.text.trim().isEmpty) {
      MyNotifications.flushbar(
        context: context,
        message: 'Enter the email and password!',
      );
    } else if (emailController.text.trim().isEmpty) {
      MyNotifications.flushbar(
        context: context,
        message: 'Enter the email...',
      );
    } else if (passwordController.text.trim().isEmpty) {
      MyNotifications.flushbar(
        context: context,
        message: 'Enter the email...',
      );
    }
  }

  signUpWithGoogle(context) async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser!.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential).then(
      (value) async {
        MyNotifications.flushbar(
          context: context,
          message: 'You\'ve signed-in successfuly...',
          icon: Icons.emoji_emotions,
        );

        UserModel userModel = UserModel(
          email: googleUser.email,
          password: '',
          name: googleUser.displayName,
          image: googleUser.photoUrl ?? '',
          user_id: FirebaseAuth.instance.currentUser!.uid,
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userModel.user_id)
            .set(userModel.toMap());

        Get.offAll(() => Home(userModel: userModel));

        loading = false;
        notifyListeners();

        clearControllers();
      },
    ).onError(
      (error, stackTrace) {
        loading = false;
        notifyListeners();

        MyNotifications.flushbar(context: context, message: error.toString());
      },
    );
  }
}
