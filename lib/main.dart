import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/firebase_config.dart';
import 'app.dart';
import 'features/auth/logic/auth_provider.dart';
import 'features/events/logic/event_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseConfig.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),
      ],
      child: const JoinNGoApp(),
    ),
  );
}
