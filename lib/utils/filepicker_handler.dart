import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<File?> pickFile({
  required List<String> extensions,
}) async {
  FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: extensions,
  );

  if (pickedFile == null) {
    return null;
  }

  return File(pickedFile.files[0].path!);
}

Future<List<File>> pickFiles({
  required List<String> extensions,
  int max = 100,
}) async {
  FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: extensions,
    allowMultiple: true,
    allowCompression: true,
  );

  if (pickedFile == null) {
    return <File>[];
  }

  List<File> parsePicked = [
    for (final file in pickedFile.files.take(max)) File(file.path!),
  ];
  return parsePicked;
}
