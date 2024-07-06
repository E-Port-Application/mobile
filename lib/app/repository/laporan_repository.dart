import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eport/app/controller/cache_controller.dart';
import 'package:eport/app/controller/laporan_controller.dart';
import 'package:eport/app/models/db/kransos/kransos_model.dart';
import 'package:eport/app/models/db/laporan/laporan_model.dart';
import 'package:eport/app/models/db/laporan_type/laporan_type_model.dart';
import 'package:eport/app/models/db/pamwal/pamwal_model.dart';
import 'package:eport/app/models/db/pelanggar/pelanggar_model.dart';
import 'package:eport/app/models/db/pengamanan/pengamanan_model.dart';
import 'package:eport/app/models/db/perizinan/perizinan_model.dart';
import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:eport/app/models/db/piket/piket_model.dart';
import 'package:eport/app/models/db/pkl/pkl_model.dart';
import 'package:eport/app/models/db/reklame/reklame_model.dart';
import 'package:eport/app/presentation/widgets/app_loading.dart';
import 'package:eport/app/repository/pelanggar_repository.dart';
import 'package:eport/firebase_options.dart';
import 'package:eport/utils/convert_timestamp.dart';
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
            } else if (temp.type == "perizinan") {
              temp.data = PerizinanModel.fromJson(data.data()!);
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
      await store.runTransaction((transaction) async {
        transaction.delete(store.collection(collection).doc(id));
        transaction.delete(store.collection("laporan").doc(id));
        if (Get.currentRoute.contains("pkl")) {
          transaction.delete(store.collection("pelanggar").doc(id));
        }
      });
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
    List<String>? cast, {
    List<String>? timestampCast,
  }) async {
    isLoading.value = true;

    try {
      if (formKey.currentState!.validate()) {
        String location = CacheController.i.address.value;
        showLoadingDialog(Get.context!, isLoading);
        final formJson = formConverter(form);
        List<PersonilModel> personils = <PersonilModel>[];

        for (var personil in personilData) {
          personils.add(personil);
        }

        formJson['personils'] = personils.map((e) => e.toJson()).toList();
        formJson['id'] = "dummy-id";
        formJson['location'] = location;

        dynamic data;
        String title = "";

        if (cast != null) {
          for (String key in cast) {
            formJson[key] = formJson[key]?.toString();
          }
        }

        convertTimestamp(formJson, [
          "tanggal",
          "waktu-mulai",
          "waktu-selesai",
          "created-at",
          "updated-at"
        ]);

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
          case "perizinan":
            data = PerizinanModel.fromJson(formJson);
            title = "Perizinan";
            break;
        }

        await FirebaseFirestore.instance.runTransaction((transaction) async {
          final dataRef = FirebaseFirestore.instance.collection(type);
          final laporanRef = FirebaseFirestore.instance.collection("laporan");

          final Map<String, dynamic> jsonData = data.toJson();
          convertTimestamp(jsonData, [
            "tanggal",
            "waktu-mulai",
            "waktu-selesai",
            "created-at",
            "updated-at"
          ]);

          DocumentReference storedDataRef = dataRef.doc();
          transaction.set(storedDataRef, jsonData);

          if (image != null) {
            var splittedFile = image.path.split(".");
            final dataStorage =
                FirebaseStorage.instance.ref().child("laporan/$type");
            String fileName = "${storedDataRef.id}.${splittedFile.last}";
            final photo = dataStorage.child(fileName);
            await photo.putFile(
              image,
              SettableMetadata(
                contentType: "image/${splittedFile.last}",
              ),
            );
            final imageUrl = {"image": await photo.getDownloadURL()};
            transaction.update(storedDataRef, imageUrl);
          }

          var updateId = {"id": storedDataRef.id};
          transaction.update(storedDataRef, updateId);

          final laporanData = LaporanModel(
            id: storedDataRef.id,
            type: type,
            progress: true,
            data: null,
            date: data.tanggal,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            location: location,
          ).toJson();

          if (type == "pkl") {
            final formPelanggar = PelanggarModel(
              name: formJson['nama-pelanggar'] ?? "",
              nik: formJson['nik-pelanggar'] ?? "",
              id: storedDataRef.id,
            );
            await PelanggarRepository.set(formPelanggar);
          }

          convertTimestamp(laporanData, ["created-at", "updated-at"]);

          transaction.set(laporanRef.doc(storedDataRef.id), laporanData);
        });

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
        List<PersonilModel> personilList = <PersonilModel>[];

        for (var personil in personils) {
          personilList.add(personil);
        }

        convertTimestamp(formJson, [
          "tanggal",
          "waktu-mulai",
          "waktu-selesai",
          "created-at",
          "updated-at"
        ]);

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
          case "perizinan":
            title = "Perizinan";
            break;
        }

        if (cast != null) {
          for (String key in cast) {
            formJson[key] = formJson[key]?.toString();
          }
        }

        await FirebaseFirestore.instance.runTransaction((transaction) async {
          final dataRef = FirebaseFirestore.instance.collection(type);
          final laporanRef = FirebaseFirestore.instance.collection("laporan");
          DocumentReference storedData = dataRef.doc(id);

          if (image != null) {
            var splittedFile = image.path.split(".");
            final dataStorage =
                FirebaseStorage.instance.ref().child("laporan/$type");
            String fileName = "${storedData.id}.${splittedFile.last}";
            final photo = dataStorage.child(fileName);
            await photo.putFile(
              image,
              SettableMetadata(
                contentType: "image/${splittedFile.last}",
              ),
            );
            final imageUrl = {"image": await photo.getDownloadURL()};
            transaction.update(storedData, imageUrl);
          }

          transaction.update(storedData, formJson);
          final laporanData = await storedData.get();
          transaction.update(laporanRef.doc(id), {
            "progress": false,
            "data": laporanData.data(),
            "updated-at": Timestamp.fromDate(DateTime.now()),
          });

          if (type == "pkl") {
            final formPelanggar = PelanggarModel(
              name: formJson['nama-pelanggar'] ?? "",
              nik: formJson['nik-pelanggar'] ?? "",
              id: storedData.id,
            );
            await PelanggarRepository.set(formPelanggar);
          }
        });

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
