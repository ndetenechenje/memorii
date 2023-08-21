import 'package:flutter/material.dart';
import 'package:memorii/widgets/image_input.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:memorii/modules/classes.dart';

class InputScreen extends StatefulWidget {
  static const routeName = 'InputScreen';

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: Color.fromARGB(255, 67, 230, 213),
        centerTitle: true,
        title: Text('Input Page'),
        actions: [
          IconButton(onPressed: onSave, icon: Icon(Icons.save)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
              ),

              SizedBox(height: 40),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
              ),

              SizedBox(height: 50),

              ImageInput(savedImages,
                  savedImage) //i created a constructor for imageInput, possible compilation error cause
            ],
          ),
        ),
      ),
    );
  }

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  File savedImage = File(''); //removed default png

  void savedImages(File image) {
    setState(() {
      savedImage = image;
    });
    print(savedImage);
  }

  void onSave() {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        savedImage == null) {
      return;
    } else {
      try {
        print(savedImage);
        Provider.of<ImageFile>(context, listen: false).addImagePlace(
            _titleController.text, _descriptionController.text, savedImage);

        Navigator.pop(context);
      } on Exception catch (e) {
        print(e);
      }
    }
  }
}
