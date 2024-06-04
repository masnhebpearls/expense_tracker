// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:expense_tracker/screens/home_page.dart' as _i1;
import 'package:flutter/material.dart' as _i3;

abstract class $AppRouter extends _i2.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    MyHomePageRoute.name: (routeData) {
      final args = routeData.argsAs<MyHomePageRouteArgs>(
          orElse: () => const MyHomePageRouteArgs());
      return _i2.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.MyHomePage(key: args.key),
      );
    }
  };
}

/// generated route for
/// [_i1.MyHomePage]
class MyHomePageRoute extends _i2.PageRouteInfo<MyHomePageRouteArgs> {
  MyHomePageRoute({
    _i3.Key? key,
    List<_i2.PageRouteInfo>? children,
  }) : super(
          MyHomePageRoute.name,
          args: MyHomePageRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MyHomePageRoute';

  static const _i2.PageInfo<MyHomePageRouteArgs> page =
      _i2.PageInfo<MyHomePageRouteArgs>(name);
}

class MyHomePageRouteArgs {
  const MyHomePageRouteArgs({this.key});

  final _i3.Key? key;

  @override
  String toString() {
    return 'MyHomePageRouteArgs{key: $key}';
  }
}
