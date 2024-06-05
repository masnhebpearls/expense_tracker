import 'package:expense_tracker/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppGoRouter{
  GoRouter router = GoRouter(
      routes: [
        GoRoute(path: '/',
        name: GoRoutePathConstants.homeRouteName,
        pageBuilder: (context, state){
          return MaterialPage(child: MyHomePage());
        }
        )
      ]
      );
}


class GoRoutePathConstants {
  static const String homeRouteName = 'home';
}