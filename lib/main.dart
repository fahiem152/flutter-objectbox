import 'package:crud_flutter_objectbox/crud/crud_page.dart';
import 'package:crud_flutter_objectbox/crud/entities/objectbox.dart';
import 'package:flutter/material.dart';

import 'objectbox.g.dart';

late Store store;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  store = (await ObjectBox.create()).store;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CrudObjectBox(),
    );
  }
}
