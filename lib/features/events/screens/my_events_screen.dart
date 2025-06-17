import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../logic/event_provider.dart';
import '../widgets/event_card.dart';

class MyEventsScreen extends StatelessWidget {
  const MyEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(child: Text('Nie jesteś zalogowany.'));
    }

    final joinedEvents = eventProvider.events
        .where((event) => event.participants.contains(user.uid))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Moje wydarzenia')),
      body: joinedEvents.isEmpty
          ? const Center(child: Text('Nie dołączyłeś jeszcze do żadnych wydarzeń.'))
          : ListView.builder(
        itemCount: joinedEvents.length,
        itemBuilder: (context, index) {
          return EventCard(event: joinedEvents[index]);
        },
      ),
    );
  }
}
