import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/event_model.dart';
import '../../auth/logic/auth_provider.dart';
import '../logic/event_provider.dart';

class EventDetailsScreen extends StatelessWidget {
  final Event event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    final isParticipant = event.participants.contains(user?.uid);

    return Scaffold(
      appBar: AppBar(title: Text(event.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event.title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 12),
            Text('Data: ${event.date.toLocal()}'),
            const SizedBox(height: 8),
            Text('Miejsce: ${event.location}'),
            const SizedBox(height: 12),
            Text('Opis:', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(event.description, style: Theme.of(context).textTheme.bodyMedium),
            const Spacer(),
            if (user != null)
              ElevatedButton(
                onPressed: () async {
                  await eventProvider.toggleUserParticipation(event, user.uid);
                },
                child: Text(isParticipant ? 'Zrezygnuj' : 'Dołącz'),
              ),
          ],
        ),
      ),
    );
  }
}
