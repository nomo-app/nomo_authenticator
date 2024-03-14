import 'package:nomo_authenticator/pages/home.dart';
import 'package:nomo_router/nomo_router.dart';
import 'package:nomo_router/router/entities/route.dart';
import 'package:route_gen/anotations.dart';

part 'routes.g.dart';

@AppRoutes()
const _routes = [
  PageRouteInfo(
    path: "/",
    page: Home,
  ),
];
