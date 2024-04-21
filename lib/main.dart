import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/index.dart';
import 'package:flutter_application_1/utils/common_data.dart';

void main() {
  runApp(const MainApp());
}

var myTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade300),
    textTheme: Typography.whiteMountainView);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My FLutter App",
      theme: myTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: appRoutes,
      home: const AppMainPage(),
    );
  }
}
