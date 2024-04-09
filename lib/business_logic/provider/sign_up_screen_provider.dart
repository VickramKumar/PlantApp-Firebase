import 'package:plant_app/exports/exports.dart';

class SignUpScreenProvider extends ChangeNotifier {
  bool loading = false;
  bool passwordObscureText = true;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  changePasswordObscureText() {
    passwordObscureText = !passwordObscureText;
    notifyListeners();
  }

  clearControllers() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  signUp(context) {
    if (nameController.text.trim().isNotEmpty &&
        emailController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty) {
      loading = true;
      notifyListeners();

      firebaseAuth
          .createUserWithEmailAndPassword(
        email: emailController.text.trim().toString(),
        password: passwordController.text.trim().toString(),
      )
          .then(
        (value) async {
          UserModel userModel = UserModel(
            email: emailController.text.trim().toString(),
            password: passwordController.text.trim().toString(),
            name: nameController.text.trim().toString(),
            image: '',
            user_id: FirebaseAuth.instance.currentUser!.uid,
          );

          await firestore
              .collection('users')
              .doc(firebaseAuth.currentUser!.uid.toString())
              .set(userModel.toMap());

          Get.offAll(() => Home(userModel: userModel));

          MyNotifications.flushbar(
            context: context,
            message: 'You\'ve signed-in successfuly...',
            icon: Icons.emoji_emotions,
          );

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
    } else {
      MyNotifications.flushbar(
        context: context,
        message: 'Please, all the fields!',
        icon: Icons.error_outline,
      );
    }
  }
}
