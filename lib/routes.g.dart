// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// RouteGenerator
// **************************************************************************

class AppRouter extends NomoAppRouter {
  AppRouter()
      : super(
          {
            HomeRoute.path: ([a]) => HomeRoute(),
          },
          _routes.expanded.where((r) => r is! NestedPageRouteInfo).toList(),
          _routes.expanded.whereType<NestedPageRouteInfo>().toList(),
        );
}

class HomeArguments {
  const HomeArguments();
}

class HomeRoute extends AppRoute implements HomeArguments {
  HomeRoute()
      : super(
          name: '/',
          page: Home(),
        );
  static String path = '/';
}
