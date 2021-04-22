import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../message_detail/view/message_detail_view.dart';
import '../../not_found_view.dart';
import '../../user_model.dart';
import '../constants/navigation_constants.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.MESSAGE_DETAIL:
        return normalNavigate(MessageDetail(user: args.arguments as UserModel));
      default:
        return MaterialPageRoute(
          builder: (context) => NotFoundView(),
        );
    }
  }

  MaterialPageRoute normalNavigate(Widget widget) {
    return MaterialPageRoute(
      builder: (context) => widget,
    );
  }
}
