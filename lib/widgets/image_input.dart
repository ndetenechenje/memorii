import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  //static const routeName = "ImageInput";

  //ImageInput(void Function(File image) savedImages, File savedImage); old code
  final void Function(File image) savedImages;
  final File savedImage;

  ImageInput(this.savedImages, this.savedImage);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Center(
          child: Container(
              height: 180,
              width: 180,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.deepOrange),
              ),
              child: _imageFile != null
                  ? Image.file(
                      _imageFile,
                      fit: BoxFit.cover,
                    )
                  : Center(
                      child: Text('Add an Image')) // text not being displayed

              ),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: TextButton.icon(
                onPressed: _gallery,
                icon: Icon(Icons.image),
                label: Text(
                  "Add your Image",
                ),
              ),
            ),
            Center(
              child: TextButton.icon(
                onPressed: _takePicture,
                icon: Icon(Icons.camera_alt),
                label: Text("Take a Picture"),
              ),
            ),
          ],
        )
      ],
    );
  }

  File _imageFile =
      File(''); //fix image error , File _imageFile;, //removed default.png
  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imageFile == null) {
      return;
    }

    setState(() {
      _imageFile = File(imageFile.path);
      widget.savedImages(_imageFile);
    });
  }

  Future<void> _gallery() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    if (imageFile == null) {
      return;
    }

    setState(() {
      _imageFile = File(imageFile.path);
      widget.savedImages(_imageFile);
    });
  }
}
