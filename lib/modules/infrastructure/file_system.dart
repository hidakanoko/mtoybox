import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileSystem {
  FileSystem();

  static final FileSystem _cache = FileSystem();
  factory FileSystem.instance() {
    return _cache;
  }

  Future<String> _getDocumentPath() async {
    Directory dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<bool> existsInDocumentPath(String path) async {
    return (await _getFileInDocumentPath(path)).existsSync();
  }

  Future<void> saveInDocumentPath(String path, String contents) async {
    (await _getFileInDocumentPath(path)).writeAsStringSync(contents);
  }

  Future<String> readInDocumentPath(String path) async {
    return (await _getFileInDocumentPath(path)).readAsStringSync();
  }

  Future<File> _getFileInDocumentPath(String path) async {
    return File("${await _getDocumentPath()}/$path");
  }
}
