import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notesapp/notespage.dart';
import 'package:provider/provider.dart';
import 'database/database.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await database.intialize();
  runApp(ChangeNotifierProvider(
    create: (context) => database(),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Notespage(),
    );
  }
}
