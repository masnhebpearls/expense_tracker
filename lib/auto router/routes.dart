import 'package:auto_route/auto_route.dart';
import 'routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'routes')
class AppRouter extends $AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: MyHomePageRoute.page, initial: true)
  ];
}