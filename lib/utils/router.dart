import 'package:auto_route/auto_route.dart';
import 'package:employee_app/utils/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route,Screen')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: AppWrapperRoute.page,
          path: '/',
          initial: true,
          children: [
            AutoRoute(
              path: EmployeeListRoute.name,
              page: EmployeeListRoute.page,
            ),
            AutoRoute(
              path: AddUpdateEmployeeRoute.name,
              page: AddUpdateEmployeeRoute.page,
            ),
          ],
        ),
      ];
}
