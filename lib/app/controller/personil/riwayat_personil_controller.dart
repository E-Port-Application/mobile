import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:eport/app/repository/personil_repository.dart';
import 'package:get/get.dart';

class RiwayatPersonilController extends GetxController {
  static RiwayatPersonilController get i => Get.find();

  RxList<PersonilModel> personils = RxList<PersonilModel>();
  RxList<PersonilModel> komandos = RxList<PersonilModel>();
  RxList<PersonilModel> anggotas = RxList<PersonilModel>();

  RxInt hadir = 0.obs;
  RxInt notHadir = 0.obs;

  Future initData() async {
    try {
      var data =
          await PersonilRepository.getDetailPersonil(Get.parameters['doc']!);

      personils.value = data;
      personils.refresh();

      komandos.value = data.where((e) => e.komando).toList();
      komandos.refresh();

      anggotas.value = data.where((e) => !e.komando).toList();
      anggotas.refresh();

      hadir.value = personils.where((p0) => p0.hadir).length;
      notHadir.value = personils.length - hadir.value;
    } catch (_) {}
  }

  @override
  void onInit() async {
    super.onInit();
    await initData();
  }
}
