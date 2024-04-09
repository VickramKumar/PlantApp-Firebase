import 'package:plant_app/exports/exports.dart';

class FirebaseHelper {
  static Future<UserModel?> getUserDataById(userId) async {
    UserModel? userModel;

    var data =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (data.data() != null) {
      userModel = UserModel.fromMap(
        data.data() as Map<String, dynamic>,
      );
    }

    return userModel;
  }
}
