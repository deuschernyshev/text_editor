import 'dart:io';

extension FileSystemEntityExtension on FileSystemEntity {
  String get name => path.replaceAll('${parent.path}/', '');
  bool get isDir => FileSystemEntity.isDirectorySync(path);
  
  String readAsStringSync() {
    final file = File(path);

    return file.readAsStringSync();
  }
}
