import 'package:eport/app/controller/global_controller.dart';
import 'package:eport/app/models/common/profile/profile_model.dart';
import 'package:eport/app/presentation/view/variant.dart';
import 'package:eport/app/presentation/widgets/app_loading.dart';
import 'package:eport/firebase_options.dart';
import 'package:eport/utils/convert_json.dart';
import 'package:eport/utils/show_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:eport/utils/filepicker_handler.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileController extends GetxController {
  static ProfileController get i => Get.find<ProfileController>();
  Rxn<User> user = Rxn<User>();
  RxList<ProfileModel> menu = RxList<ProfileModel>([]);

  @override
  void onInit() async {
    super.onInit();
    user.value = GlobalController.i.user.value;
    GlobalController.i.user.listen((p0) {
      user.value = p0;
    });

    menu.value = await convertJson<ProfileModel>("assets/data/profiles.json");
  }

  RxBool isLoading = true.obs;
  void updatePhoto() async {
    if (user.value == null) {
      return;
    }
    try {
      final file = await pickFile(extensions: ['jpg', 'png', 'jpeg']);
      if (file == null) {
        return;
      }
      isLoading.value = true;
      showLoadingDialog(Get.context!, isLoading);
      isLoading.value = true;
      final userPhoto = ppStorage.child(user.value!.uid);
      await userPhoto.putFile(file, SettableMetadata(contentType: "image"));

      String url = await userPhoto.getDownloadURL();
      await user.value!.updatePhotoURL(url);
      showAlert("Berhasil ganti photo profile", isSuccess: true);
    } on Exception catch (err) {
      showAlert(err.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void logout() async {
    try {
      await auth.signOut();
      await GoogleSignIn().signOut();
      Get.offAllNamed(Onboard.path());
    } catch (err) {
      showAlert(err.toString());
    }
  }
}
