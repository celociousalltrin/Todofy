import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/about.dart';
import 'package:flutter_application_1/pages/api_todo.dart';
import 'package:flutter_application_1/pages/api_view.dart';
import 'package:flutter_application_1/pages/cubit_page/index.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/index.dart';
import 'package:go_router/go_router.dart';

class MyAppRouter {
  final GoRouter _router;

  MyAppRouter() : _router = _buildRouter();

  static GoRouter _buildRouter() {
    return GoRouter(
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const AppMainPage();
          },
        ),
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return const Homepage();
          },
        ),
        GoRoute(
          path: '/about',
          name: 'about',
          builder: (BuildContext context, GoRouterState state) {
            return const AboutPage();
          },
        ),
        GoRoute(
          path: '/cubit',
          name: 'cubit',
          builder: (BuildContext context, GoRouterState state) {
            return const CubitPage();
          },
        ),
        GoRoute(
            path: '/api-todo',
            name: 'api-todo',
            builder: (BuildContext context, GoRouterState state) {
              return const ApiTodoPage();
            },
            routes: [
              GoRoute(
                  path: 'api-todo/:id',
                  name: "api-todo-id",
                  builder: (BuildContext context, GoRouterState state) {
                    return ApiViewPage(
                        id: int.parse(state.pathParameters["id"]!));
                  })
            ]),
      ],
    );
  }

  GoRouter get router => _router;
}
