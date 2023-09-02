import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mtoybox/modules/domain/model/article/photo.dart';

class GalleryButton extends StatelessWidget {
  final void Function(Photo photo) onPick;
  const GalleryButton(this.onPick, {super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => {takePhotFromCamera()},
      icon: const Icon(Icons.photo_library),
      iconSize: 40,
    );
  }

  takePhotFromCamera() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);
    if (img == null) return;

    onPick(Photo(img.path, isBuiltin: false));
  }
}
