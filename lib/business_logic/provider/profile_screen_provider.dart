import 'dart:io';

import 'package:plant_app/exports/exports.dart';

class ProfileScreenProvider extends ChangeNotifier {
  bool loading = false;

  String imagePath = '';
  String downloadedImageUrl = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();

  pickImage(source) async {
    var image = await ImagePicker().pickImage(source: source);

    if (image != null) {
      imagePath = image.path;
      notifyListeners();
    }
  }

  uploadImage() async {
    if (imagePath != '') {
      var reference = FirebaseStorage.instance
          .ref('images')
          .child(FirebaseAuth.instance.currentUser!.uid);

      await reference.putFile(File(imagePath));

      downloadedImageUrl = await reference.getDownloadURL();
    }
  }

  uploadEditedData(
      BuildContext context, String currentPassword, String oldImage) async {
    if (nameController.text.trim().isEmpty ||
        currentPasswordController.text.trim().isEmpty ||
        newPasswordController.text.trim().isEmpty) {
      MyNotifications.flushbar(
          icon: Icons.emoji_emotions,
          context: context,
          message: 'Please, fill all the above Fields...');
    } else if (currentPasswordController.text.trim().toString() !=
        currentPassword) {
      MyNotifications.flushbar(
        context: context,
        message: 'The Current Password is Incorrect...',
      );
    } else {
      loading = true;
      notifyListeners();

      await uploadImage();

      var credential = EmailAuthProvider.credential(
        email: FirebaseAuth.instance.currentUser!.email.toString(),
        password: currentPassword,
      );

      await FirebaseAuth.instance.currentUser!
          .reauthenticateWithCredential(credential)
          .then(
        (value) {
          FirebaseAuth.instance.currentUser!
              .updatePassword(newPasswordController.text.trim());
        },
      ).onError(
        (error, stackTrace) {
          MyNotifications.flushbar(
            context: context,
            message: '$error',
          );
        },
      );

      UserModel userModel = UserModel(
        email: FirebaseAuth.instance.currentUser!.email,
        password: newPasswordController.text.trim().toString(),
        name: nameController.text.trim().toString(),
        image: downloadedImageUrl.isEmpty
            ? oldImage
            : downloadedImageUrl.toString(),
        user_id: FirebaseAuth.instance.currentUser!.uid,
      );

      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(userModel.toMap(), SetOptions(merge: true))
          .then(
        (value) async {
          MyNotifications.flushbar(
            icon: Icons.emoji_emotions,
            context: context,
            message: 'Your Data has been Successfuly Edited...',
          );

          loading = false;
          notifyListeners();

          imagePath = '';

          currentPasswordController.clear();
          newPasswordController.clear();

          Navigator.pop(context);
        },
      ).onError(
        (error, stackTrace) {
          MyNotifications.flushbar(
            icon: Icons.emoji_emotions,
            context: context,
            message: error.toString(),
          );

          loading = false;
          notifyListeners();
        },
      );
    }
  }
}
