// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pkl_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PklModel _$PklModelFromJson(Map<String, dynamic> json) => PklModel(
      tanggal: DateTime.parse(json['tanggal'] as String),
      waktuMulai: DateTime.parse(json['waktu-mulai'] as String),
      waktuSelesai: DateTime.parse(json['waktu-selesai'] as String),
      createdAt: json['created-at'] == null
          ? null
          : DateTime.parse(json['created-at'] as String),
      updatedAt: json['updated-at'] == null
          ? null
          : DateTime.parse(json['updated-at'] as String),
      jenis: json['jenis'] as String?,
      pelanggaran: json['pelanggaran'] as String?,
      tindakan: json['tindakan'] as String?,
      jumlahPelanggar: json['jumlah-pelanggar'] as int?,
      personils: (json['personils'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      keterangan: json['keterangan'] as String?,
      image: json['image'] as String?,
      alamatPelanggar: json['alamat-pelanggar'] as String?,
      jenisKelamin: json['jenis-kelamin'] as String?,
      namaPelanggar: json['nama-pelanggar'] as String?,
      nikPelanggar: json['nik-pelanggar'] as String?,
    );

Map<String, dynamic> _$PklModelToJson(PklModel instance) => <String, dynamic>{
      'tanggal': instance.tanggal.toIso8601String(),
      'waktu-mulai': instance.waktuMulai.toIso8601String(),
      'waktu-selesai': instance.waktuSelesai.toIso8601String(),
      'jenis': instance.jenis,
      'pelanggaran': instance.pelanggaran,
      'tindakan': instance.tindakan,
      'jumlah-pelanggar': instance.jumlahPelanggar,
      'personils': instance.personils,
      'keterangan': instance.keterangan,
      'image': instance.image,
      'nama-pelanggar': instance.namaPelanggar,
      'nik-pelanggar': instance.nikPelanggar,
      'jenis-kelamin': instance.jenisKelamin,
      'alamat-pelanggar': instance.alamatPelanggar,
      'created-at': instance.createdAt?.toIso8601String(),
      'updated-at': instance.updatedAt?.toIso8601String(),
    };
