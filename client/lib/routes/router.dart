import 'package:client/routes/route_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationHandler {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static const initalRoute = '/';

  static Route? onGenerate(RouteSettings settings) {
    final name = settings.name;
    final arguments = settings.arguments;

    if (arguments is RouteData) {
      return _getRoute(arguments);
    }
    return null;
  }

  static Route _getRoute(RouteData routeParam) {
    return CupertinoPageRoute(
      builder: (context) {
        return routeParam.build(context);
      },
    );
  }
}
