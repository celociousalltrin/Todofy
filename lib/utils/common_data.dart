import 'package:flutter_application_1/pages/about.dart';
import 'package:flutter_application_1/pages/cubit_page/index.dart';
import 'package:flutter_application_1/pages/home.dart';

final appRoutes = {
  "/home": (_) => const Homepage(),
  "/about": (_) => const AboutPage(),
  "/cubit": (_) => const CubitPage()
};

const appNavigationData = [
  {"title": "To DO", "route": "/home"},
  {"title": "About", "route": "/about"},
  {"title": "Cubit", "route": "/cubit"},
];