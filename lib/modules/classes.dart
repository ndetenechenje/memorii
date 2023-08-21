import 'dart:io';
import 'package:flutter/material.dart';
import 'database.dart';

class Image {
  final String id;
  final String title;
  final String description;
  final File image;

  Image(
      {required this.image,
      required this.id,
      required this.title,
      required this.description});

  static file(File file, {required BoxFit fit}) {} //method was created for file
}

class ImageFile extends ChangeNotifier {
  List<Image> _items = [];
  List<Image> get items {
    return [..._items];
  }


  Future<void> addImagePlace(
      String title, String description, File image) async {
    final newImage = Image(
        image: image,
        title: title,
        id: DateTime.now().toString(),
        description: description);

        _items.add(newImage);
        notifyListeners();
        DataHelper.insert('user_image', {
          'id': newImage.id,
          'description': newImage.description,
          'image': newImage.image.path,
          'title': newImage.title,
        });
  
  
  
  }
Image findImage(String imageId){


  return _items.firstWhere((image) => image.id==imageId);
}


Future<void> fetchImage() async {
  final list = await DataHelper.getData('user_image');
  _items = list
      .map((item) => Image(
            id: item['id'],
            title: item['title'],
            description: item['description'],
            image: File(item['image']),
          ))
      .toList();
  notifyListeners();
}

  
}

