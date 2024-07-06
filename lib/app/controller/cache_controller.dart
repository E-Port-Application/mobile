import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:eport/utils/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:eport/app/repository/personil_repository.dart';

class CacheController extends GetxController {
  static CacheController get i => Get.find<CacheController>();

  RxList<PersonilModel> personils = RxList<PersonilModel>();
  RxList<PersonilModel> komandos = RxList<PersonilModel>();
  RxList<PersonilModel> anggotas = RxList<PersonilModel>();
  Rxn<Position> position = Rxn<Position>();
  RxString address = "".obs;

  void getPersonis() async {
    try {
      var data = await PersonilRepository.getPersonels();
      personils.value = data[0];
      komandos.value = data[1];
      anggotas.value = data[2];
    } catch (_) {}
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text('Location permissions are denied'),
          ),
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showAlert(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
      return false;
    }
    return true;
  }

  Future<void> getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            this.position.value!.latitude, this.position.value!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      address.value =
          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then(
      (Position position) async {
        this.position.value = position;
        await getAddressFromLatLng(position);
      },
    ).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void onInit() {
    super.onInit();
    getPersonis();
  }
}
