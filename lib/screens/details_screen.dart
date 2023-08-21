import 'package:flutter/material.dart';
import 'package:memorii/modules/classes.dart' as ima;
import 'package:provider/provider.dart';

class Details extends StatelessWidget {
  static const routeName = "Details";
  @override
  Widget build(BuildContext context) {
    final imageId = ModalRoute.of(context)?.settings.arguments
        as String;
    final image =
        Provider.of<ima.ImageFile>(context, listen: false).findImage(imageId);
    return Scaffold(
      appBar: AppBar(
        title: Text(image.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              height: 400,
              width: double.infinity,
              child: Image.file(image.image, fit: BoxFit.cover),
            ),
          ),
          Text(image.title, style: TextStyle(fontSize: 30)),
          SizedBox(height: 20),
          Text(image.description, style: TextStyle(fontSize: 30)),
        ],
      ),
    );
  }
}
