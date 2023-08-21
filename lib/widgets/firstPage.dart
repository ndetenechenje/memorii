import 'package:flutter/material.dart';
import 'package:memorii/widgets/image_input.dart';
//import 'screens/homepage.dart';
import 'package:memorii/screens/homepage.dart';
//import 'widgets/input_screen.dart';
import 'package:memorii/widgets/input_screen.dart';
import 'package:provider/provider.dart';
import 'package:memorii/modules/classes.dart'; //might need to change it to full path
//import 'screens/details_screen.dart';
import 'package:memorii/screens/details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider(
      create: (ctx) => ImageFile(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Memorii Gallery",
        theme: ThemeData.light(),
        home: homepage(),
        routes: {
         
          InputScreen.routeName: (ctx) => InputScreen(),
          Details.routeName : (ctx) =>Details(),
        },
      ),
    );
  }
}
