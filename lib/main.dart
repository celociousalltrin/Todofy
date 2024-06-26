import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/api_store.dart';
import 'package:flutter_application_1/routes/index.dart';
import 'package:flutter_application_1/service/api_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  DioClient.setupInterceptors();
  runApp(const MainApp());
}

var myTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade300),
    textTheme: Typography.whiteMountainView);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final MyAppRouter myAppRouter = MyAppRouter();
    return BlocProvider(
        create: (_) => ApiTodoStore(),
        child: MaterialApp.router(
          title: "My FLutter App",
          theme: myTheme,
          debugShowCheckedModeBanner: false,
          routeInformationParser: myAppRouter.router.routeInformationParser,
          routerDelegate: myAppRouter.router.routerDelegate,
          routeInformationProvider: myAppRouter.router.routeInformationProvider,
        ));
  }
}
