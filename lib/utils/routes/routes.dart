import 'package:clump_project/view/company_details.dart';
import 'package:clump_project/view/lead_view.dart';
import 'package:clump_project/view/profile_view.dart';
import 'package:flutter/material.dart';

import '../../view/home_screen.dart';
import '../../view/login_view.dart';
import '../../view/signup_view.dart';
import '../../view/splash_view.dart';
import 'routes_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => LoginScreen());

      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case RoutesName.signup:
        return MaterialPageRoute(builder: (context) => SignupScreen());
      case RoutesName.spalsh:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case RoutesName.lead:
        return MaterialPageRoute(builder: (context) => LeadsScreen());
      case RoutesName.comapnyDetails:
        return MaterialPageRoute(builder: (context) => CompanyDetailsPage());
      case RoutesName.profile:
        return MaterialPageRoute(builder: (context) => UserFormScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text(' No route found'),
            ),
          );
        });
    }
  }
}
