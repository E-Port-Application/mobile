import 'package:eport/app/models/db/user/user_model.dart';
import 'package:eport/app/presentation/widgets/app_loading.dart';
import 'package:eport/firebase_options.dart';
import 'package:eport/global_settings.dart';
import 'package:eport/routes/app_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  static Future roleValidate(UserCredential authData, RxBool isLoading) async {
    if (authData.user == null) {
      closeLoading(isLoading);
      return;
    }
    final user = authData.user!;
    final userRef = store.collection("user").doc(user.uid);
    final userData = await userRef.get();
    if (userData.data() == null) {
      await store.collection("user").doc(user.uid).set(
            UserModel(
              displayName: user.displayName,
              email: user.email,
              emailVerified: user.emailVerified,
              phoneNumber: user.phoneNumber,
              photoURL: user.photoURL,
              uid: user.uid,
              internal: !Global.isExt(),
            ).toJson(),
          );
      closeLoading(isLoading);
      Get.offAllNamed(AppRoute.home);
      return;
    }

    final userModelData = UserModel.fromJson(userData.data()!);
    if (!userModelData.internal != Global.isExt()) {
      await auth.signOut();
      await GoogleSignIn().signOut();
      throw Exception("Account is invalid");
    }
    closeLoading(isLoading);
    Get.offAllNamed(AppRoute.home);
  }
}
