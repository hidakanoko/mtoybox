import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mtoybox/modules/domain/model/article/photo.dart';

class CameraButton extends StatelessWidget {
  final void Function(Photo photo) onTake;
  const CameraButton(this.onTake, {super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => {takePhotFromCamera()},
      icon: const Icon(Icons.camera_alt),
      iconSize: 40,
    );
  }

  takePhotFromCamera() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.camera);
    if (img == null) return;

    onTake(Photo(img.path, isBuiltin: false));
  }
}
