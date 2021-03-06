import 'package:flutter/material.dart';

import 'package:qr_reader_app/src/pages/home_page.dart';
import 'package:qr_reader_app/src/pages/show_map_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Reader',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'mapa': (BuildContext context) => ShowMapPage(),
      },
      theme: ThemeData(primaryColor: Colors.indigo),
    );
  }
}
