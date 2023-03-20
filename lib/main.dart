import 'package:flutter/material.dart';
import 'package:kharcha_book/db/database_service.dart';
import 'package:kharcha_book/screens/homepage/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseService().connectDb();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Kharcha Book',
      home: MyHomePage(),
    );
  }
}
