import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eport/app/controller/laporan_controller.dart';
import 'package:eport/app/models/db/kransos/kransos_model.dart';
import 'package:eport/app/models/db/laporan/laporan_model.dart';
import 'package:eport/app/models/db/laporan_type/laporan_type_model.dart';
import 'package:eport/app/models/db/pamwal/pamwal_model.dart';
import 'package:eport/app/models/db/pengamanan/pengamanan_model.dart';
import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:eport/app/models/db/piket/piket_model.dart';
import 'package:eport/app/models/db/pkl/pkl_model.dart';
import 'package:eport/app/models/db/reklame/reklame_model.dart';
import 'package:eport/app/presentation/widgets/app_loading.dart';
import 'package:eport/firebase_options.dart';
import 'package:eport/utils/form_converter.dart';
import 'package:eport/utils/show_alert.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LaporanRepository {
  static Future<List<LaporanTypeModel>> getSearchData(String ref) async {
    try {
      final storeRef = store.collection(ref);
      var data = await storeRef.get();
      return data.docs.map((e) {
        return LaporanTypeModel.fromJson(e.data());
      }).toList();
    } catch (err) {
      showAlert(err.toString());

      rethrow;
    }
  }

  static Future createPkl() async {
    try {} catch (err) {
      showAlert(err.toString());
    }
  }

  static Future<List<LaporanModel>> getReportData(
      {required bool isProgress}) async {
    try {
      final laporanRef = store
          .collection("laporan")
          .where("progress", isEqualTo: isProgress)
          .orderBy("date", descending: true);

      var laporans = await laporanRef.get();
      return (await Future.wait(
        laporans.docs.map(
          (e) async {
            var temp = LaporanModel.fromJson(e.data());
            final dataRef = store.collection(temp.type).doc(temp.id);
            var data = await dataRef.get();
            if (temp.type == "pkl") {
              temp.data = PklModel.fromJson(data.data()!);
            } else if (temp.type == "reklame") {
              temp.data = ReklameModel.fromJson(data.data()!);
            } else if (temp.type == "kransos") {
              temp.data = KransosModel.fromJson(data.data()!);
            } else if (temp.type == "pengamanan") {
              temp.data = PengamananModel.fromJson(data.data()!);
            } else if (temp.type == "pamwal") {
              temp.data = PengamananModel.fromJson(data.data()!);
            } else if (temp.type == "piket") {
              temp.data = PiketModel.fromJson(data.data()!);
            }

            return temp;
          },
        ),
      ))
          .toList();
    } catch (err) {
      showAlert(err.toString());
      rethrow;
    }
  }

  static Future<PklModel> getPklDetail(String id) async {
    try {
      final pklRef = store.collection("pkl");
      var data = await pklRef.doc(id).get();
      return PklModel.fromJson(data.data()!);
    } catch (err) {
      showAlert(err.toString());
      rethrow;
    }
  }

  static Future<ReklameModel> getReklameDetail(String id) async {
    try {
      final pklRef = store.collection("reklame");
      var data = await pklRef.doc(id).get();
      return ReklameModel.fromJson(data.data()!);
    } catch (err) {
      showAlert(err.toString());
      rethrow;
    }
  }

  static remove(String collection, String id) async {
    try {
      var a = storage.child("laporan/$collection/$id.jpg");
      a.delete().then((_) {}).catchError((_) {});
      await store.collection(collection).doc(id).delete();
      await store.collection("laporan").doc(id).delete();
    } catch (err) {
      showAlert(err.toString());
      rethrow;
    }
  }

  static void create(
    RxBool isLoading,
    GlobalKey<FormState> formKey,
    RxMap<String, TextEditingController> form,
    List<PersonilModel> personilData,
    File? image,
    String type,
    List<String>? cast,
  ) async {
    isLoading.value = true;

    try {
      if (formKey.currentState!.validate()) {
        showLoadingDialog(Get.context!, isLoading);
        final formJson = formConverter(form);
        List<PersonilModel> personils = <PersonilModel>[];

        for (var personil in personilData) {
          personils.add(personil);
        }
        formJson['personils'] = personils.map((e) => e.toJson()).toList();
        formJson['id'] = "dummy-id";

        dynamic data;
        String title = "";
        switch (type) {
          case "pkl":
            data = PklModel.fromJson(formJson);
            title = "PKL";
            break;
          case "reklame":
            data = ReklameModel.fromJson(formJson);
            title = "Reklame";
            break;
          case "kransos":
            data = KransosModel.fromJson(formJson);
            title = "Keransos";
            break;
          case "pengamanan":
            data = PengamananModel.fromJson(formJson);
            title = "Pengamanan";
            break;
          case "pamwal":
            data = PamwalModel.fromJson(formJson);
            title = "Pamwal";
            break;
          case "piket":
            data = PiketModel.fromJson(formJson);
            title = "Piket";
            break;
        }

        if (cast != null) {
          for (String key in cast) {
            formJson[key] = formJson[key]?.toString();
          }
        }

        final dataRef = store.collection(type);
        final laporanRef = store.collection("laporan");
        DocumentReference storedData = await dataRef.add(data.toJson());

        if (image != null) {
          var splittedFile = image.path.split(".");
          final dataStorage = storage.child("laporan/$type");
          String fileName = "${storedData.id}.${splittedFile.last}";
          final photo = dataStorage.child(fileName);
          await photo.putFile(
            image,
            SettableMetadata(
              contentType: "image/${splittedFile.last}",
            ),
          );
          final imageUrl = {"image": await photo.getDownloadURL()};
          await storedData.update(imageUrl);
        }

        var updateId = {"id": storedData.id};
        await storedData.update(updateId);

        final laporanData = LaporanModel(
          id: storedData.id,
          type: type,
          progress: true,
          data: null,
          date: data.tanggal,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ).toJson();

        await laporanRef.doc(storedData.id).set(laporanData);

        await closeLoading(isLoading);
        showAlert("Berhasil membuat rencana kegiatan patroli $title",
            isSuccess: true);
        LaporanController.i.getData();
        Get.back();
      }
    } catch (err) {
      await closeLoading(isLoading);
      showAlert(err.toString());
    }
  }

  static void update(
    String id,
    RxBool isLoading,
    GlobalKey<FormState> formKey,
    RxMap<String, TextEditingController> form,
    List<PersonilModel> personils,
    File? image,
    String type,
    List<String>? cast,
  ) async {
    isLoading.value = true;
    try {
      if (formKey.currentState!.validate()) {
        showLoadingDialog(Get.context!, isLoading);
        final formJson = formConverter(form);
        List<PersonilModel> personils = <PersonilModel>[];

        for (var personil in personils) {
          personils.add(personil);
        }

        String title = "";
        switch (type) {
          case "pkl":
            title = "PKL";
            break;
          case "reklame":
            title = "Reklame";
            break;
          case "kransos":
            title = "Keransos";
            break;
          case "pengamanan":
            title = "Pengamanan";
            break;
          case "pamwal":
            title = "Pamwal";
            break;
          case "piket":
            title = "Piket";
            break;
        }

        if (cast != null) {
          for (String key in cast) {
            formJson[key] = formJson[key]?.toString();
          }
        }

        final dataRef = store.collection(type);
        final laporanRef = store.collection("laporan");
        DocumentReference storedData;
        storedData = dataRef.doc(id);

        if (image != null) {
          var splittedFile = image.path.split(".");
          final dataStorage = storage.child("laporan/$type");
          String fileName = "${storedData.id}.${splittedFile.last}";
          final photo = dataStorage.child(fileName);
          await photo.putFile(
            image,
            SettableMetadata(
              contentType: "image/${splittedFile.last}",
            ),
          );
          final imageUrl = {"image": await photo.getDownloadURL()};
          await storedData.update(imageUrl);
        }

        await laporanRef.doc(id).update({"progress": false});
        await storedData.update(formJson);

        await closeLoading(isLoading);
        showAlert("Berhasil membuat laporan kegiatan patroli $title",
            isSuccess: true);
        LaporanController.i.getData();
        Get.back();
      }
    } catch (err) {
      await closeLoading(isLoading);
      showAlert(err.toString());
    }
  }
}
