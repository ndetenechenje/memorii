import 'package:flutter/material.dart';
import 'package:memorii/widgets/input_screen.dart';
import 'package:provider/provider.dart';
import 'package:memorii/modules/classes.dart' as ima; // updated import
import 'dart:io';
import 'details_screen.dart';

class homepage extends StatelessWidget {
  const homepage({Key? key});
  //static const routeName = "homepage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, InputScreen.routeName);
        },
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),

        backgroundColor: Color.fromARGB(255, 67, 230, 213),
        child: Icon(
          Icons.image,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: Text('Memorii Gallery', style: TextStyle(fontFamily: 'MyCustomFont', fontSize: 20, fontWeight: FontWeight.bold),),
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: Color.fromARGB(255, 67, 230, 213),
        centerTitle: true,
      ),
      
      body: FutureBuilder(
        future: Provider.of<ima.ImageFile>(context, listen: false).fetchImage(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<ima.ImageFile>(
                    child: Center(child: Text("Start adding your story")),
                    builder: (ctx, image, ch) {
                      print(image.items.length);

                      return image.items.length >= 0
                          ? GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                childAspectRatio: 3 / 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemBuilder: (ctx, i) => Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: GridTile(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, Details.routeName,
                                            arguments: image.items[i].id);
                                      },
                                      child: Image.file(
                                        image.items[i].image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  footer: GridTileBar(
                                    leading: Text(
                                      image.items[i].title,
                                      style: TextStyle(fontSize: 30.0, color: Colors.white, ),
                                    ),
                                    title: Text(''),
                                    subtitle: Text(image.items[i].description),
                                    trailing: Text(image.items[i].id),
                                  ),
                                ),
                              ),
                              itemCount: image.items.length,
                            )
                          : ch!;
                    }),
      ),
    );
  }
}
