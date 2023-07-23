import 'package:flutter_test/flutter_test.dart';
import 'package:mtoybox/modules/domain/model/article/photo.dart';
import 'package:mtoybox/modules/interface/converter/photo_map_converter.dart';

main() {
  final photoMapConverter = PhotoMapConverter();
  test('PhotoMapConverter toMap', () {
    // given
    const photo = Photo('/path/to/photo', isBuiltin: true);

    // when, then
    expect(photoMapConverter.toMap(photo),
        {'path': '/path/to/photo', 'isBuiltin': true});
  });

  test('PhotoMapConverter fromMap', () {
    // given
    const map = {'path': '/path/to/photo', 'isBuiltin': true};

    // when, then
    identical(photoMapConverter.fromMap(map),
        const Photo('/path/to/photo', isBuiltin: true));
  });
}
