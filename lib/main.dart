import 'package:clump_project/utils/routes/routes.dart';
import 'package:clump_project/utils/routes/routes_name.dart';
import 'package:clump_project/view/lead_view.dart';
import 'package:clump_project/view/login_view.dart';
import 'package:clump_project/view_model/auth_provider.dart';
import 'package:clump_project/view_model/lead_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authProvider = AuthProvider();
  await authProvider.loadUserData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final authProvider = AuthProvider();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LeadProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        initialRoute:
            authProvider.token == null ? RoutesName.spalsh : RoutesName.home,
        onGenerateRoute: Routes.generateRoute,
        title: 'Flutter Demo',
      ),
    );
  }
}
