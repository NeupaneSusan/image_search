import 'package:flutter/material.dart';
import 'package:imagesearch/controller/image_controller.dart';
import 'package:provider/provider.dart';

import 'view/myhome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ImageController>(
      create: (context) => ImageController(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}



