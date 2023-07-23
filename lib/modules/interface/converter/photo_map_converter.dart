import 'package:mtoybox/modules/domain/model/article/photo.dart';

class PhotoMapConverter {
  Map<String, dynamic> toMap(Photo photo) {
    return {'path': photo.path, 'isBuiltin': photo.isBuiltin};
  }

  Photo fromMap(Map<String, dynamic> map) {
    return Photo(map['path'], isBuiltin: map['isBuiltin']);
  }
}
