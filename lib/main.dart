import 'package:flutter/material.dart';

import 'composition_root.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CompositionRoot.configure();
  final showStartPage = await CompositionRoot.startPage();
  runApp(MyApp(showStartPage));
}

class MyApp extends StatelessWidget {
  final Widget showStartPage;
  MyApp(this.showStartPage);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: showStartPage,
      debugShowCheckedModeBanner: false,
    );
  }
}
