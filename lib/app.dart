import 'package:flutter/material.dart';
import 'routing/app_routes.dart';

class JoinNGoApp extends StatelessWidget {
  const JoinNGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Join’nGo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: appRoutes,
    );
  }
}