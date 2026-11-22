import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TypeImage extends StatefulWidget {
  const TypeImage(this.onSelectedImage,{super.key});
  final void Function(File image) onSelectedImage;
  @override
  State<TypeImage> createState() {
    return _TypeImageState();
  }
}

class _TypeImageState extends State<TypeImage> {
  File? selecetedImage;
  void takeImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (pickedImage == null) {
      return;
    } else {
      setState(() {
        selecetedImage = File(pickedImage.path);
      });
      widget.onSelectedImage(selecetedImage!);
    }
  }

  @override
  Widget build(ctx) {
    Widget content = TextButton.icon(
      onPressed: takeImage,
      icon: Icon(Icons.camera_alt_sharp),
      label: Text('Take Image'),
    );
    if (selecetedImage != null) {
      content = GestureDetector(
        onTap: takeImage,
        child:Image.file(
        selecetedImage!,
        width: double.infinity,
        fit: BoxFit.cover,
        height: double.infinity,
       ) );
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(ctx).colorScheme.onSurface.withValues(alpha: 0.3),
        ),
      ),
      height: 210,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}
