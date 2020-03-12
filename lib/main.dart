import 'package:flutter/material.dart';
import 'package:flutter_list/pages/home_page.dart';
import 'package:flutter_list/state/states.dart';


import 'package:provider/provider.dart';

void main() {

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create : (_) => FavoriteState()),
          ChangeNotifierProvider(create: (_) => ThemeState()),
        ],
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Provider.of<ThemeState>(context).themeData;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: HomePage(),
    );
  }
  
}


