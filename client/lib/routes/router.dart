import 'package:client/routes/route_data.dart';
import 'package:client/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationHandler {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static const initialRoute = '/';

  static Route? onGenerate(RouteSettings settings) {
    final name = settings.name;
    final arguments = settings.arguments;

    if (name == initialRoute) {
      return _getRoute(LoginRoute());
    }

    if (arguments is RouteData) {
      return _getRoute(arguments);
    }
    return null;
  }

  static Route _getRoute(RouteData routeParam) {
    print("Navigating to ${routeParam.routeName} args: ${routeParam}");
    return CupertinoPageRoute(
      builder: (context) {
        return routeParam.build(context);
      },
    );
  }
}
