import 'package:flutter/material.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/events/screens/events_list_screen.dart';
import '/features/events/screens/register_screen.dart';
import '../features/events/screens/add_event_screen.dart';
import '../features/auth/screens/profile_screen.dart';
import '../features/events/screens/my_events_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const LoginScreen(),
  '/login': (context) => const LoginScreen(),
  '/events' : (context) => const EventsListScreen(),
  '/register': (context) => const RegisterScreen(),
  '/add_event': (context) => const AddEventScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/my_events': (context) => const MyEventsScreen()
};