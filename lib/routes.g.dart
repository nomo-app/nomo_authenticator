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
            EditOTPScreenRoute.path: ([a]) {
              final typedArgs = a as EditOTPScreenArguments?;
              return EditOTPScreenRoute(
                item: typedArgs?.item,
              );
            },
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

class EditOTPScreenArguments {
  final StorageItem? item;
  const EditOTPScreenArguments({
    this.item,
  });
}

class EditOTPScreenRoute extends AppRoute implements EditOTPScreenArguments {
  @override
  final StorageItem? item;
  EditOTPScreenRoute({
    this.item,
  }) : super(
          name: '/edit',
          page: EditOTPScreen(
            item: item,
          ),
        );
  static String path = '/edit';
}
