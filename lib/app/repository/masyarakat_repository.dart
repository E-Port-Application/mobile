import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eport/app/controller/cache_controller.dart';
import 'package:eport/app/controller/global_controller.dart';
import 'package:eport/app/models/db/laporan_external/laporan_external_model.dart';
import 'package:eport/app/presentation/widgets/app_loading.dart';
import 'package:eport/firebase_options.dart';
import 'package:eport/global_settings.dart';
import 'package:eport/utils/convert_timestamp.dart';
import 'package:eport/utils/form_converter.dart';
import 'package:eport/utils/show_alert.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MasyarakatRepository {
  static Future<List<LaporanExternalModel>> getAll({
    DateTime? startDate,
    DateTime? endDate,
    String? type,
  }) async {
    startDate ??= DateTime(2000);
    endDate ??= DateTime(2100);
    try {
      var ref = store
          .collection("masyarakat")
          .where("tanggal", isGreaterThan: startDate)
          .where("tanggal", isLessThan: endDate);

      if (Global.isExt()) {
        ref = ref.where("uid", isEqualTo: GlobalController.i.user.value!.uid);
      }
      if (type != null) {
        ref = ref.where("keluhan", isEqualTo: type);
      }
      ref = ref.orderBy("tanggal", descending: true);
      var dataJson = await ref.get();
      return dataJson.docs
          .map((e) => LaporanExternalModel.fromJson(e.data()))
          .toList();
    } catch (err) {
      showAlert(err.toString());
      rethrow;
    }
  }

  static Future<LaporanExternalModel> getDetail(String id) async {
    try {
      final ref = store.collection("masyarakat").doc(id);
      var data = await ref.get();
      return LaporanExternalModel.fromJson(data.data()!);
    } catch (err) {
      showAlert(err.toString());
      rethrow;
    }
  }

  static Future create(
    RxBool isLoading,
    GlobalKey<FormState> formKey,
    RxMap<String, TextEditingController> form,
    File image,
    List<String>? cast, {
    List<String>? timestampCast,
  }) async {
    isLoading.value = true;

    try {
      if (formKey.currentState!.validate()) {
        showLoadingDialog(Get.context!, isLoading);
        String location = CacheController.i.address.value;
        final formJson = formConverter(form);

        formJson['id'] = "dummy-id";
        formJson['image'] = "";
        formJson['location'] = location;

        if (cast != null) {
          for (String key in cast) {
            formJson[key] = formJson[key]?.toString();
          }
        }

        convertTimestamp(
          formJson,
          ["tanggal", "created-at", "updated-at"],
        );
        print(formJson);

        LaporanExternalModel data = LaporanExternalModel.fromJson(
          formJson,
        );

        await store.runTransaction((transaction) async {
          final dataRef = store.collection("masyarakat");

          final Map<String, dynamic> jsonData = data.toJson();
          convertTimestamp(jsonData, ["tanggal", "created-at", "updated-at"]);

          DocumentReference storedDataRef = dataRef.doc();
          transaction.set(storedDataRef, jsonData);

          var splittedFile = image.path.split(".");
          final dataStorage = storage.child("laporan/masyarakat");
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

          var updateId = {"id": storedDataRef.id};
          transaction.update(storedDataRef, updateId);
        });

        await closeLoading(isLoading);
        const alertText = "Berhasil membuat Laporan";
        showAlert(alertText, isSuccess: true);
        Get.back();
      }
    } catch (err) {
      await closeLoading(isLoading);
      showAlert(err.toString());
    }
  }
}
