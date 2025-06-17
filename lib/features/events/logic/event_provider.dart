import '../models/event_model.dart';
import 'package:flutter/material.dart';
import '/services/firestore_service.dart';

class EventProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<Event> _events = [];
  List<Event> get events => _events;

  void startListening() {
    _firestoreService.getEventsStream().listen((eventList) {
      _events = eventList;
      notifyListeners();
    });
  }

  Future<void> addEvent(String title, String description, DateTime date, String location) async {
    final newEvent = Event(
      id: '', // ID zostanie ustawione przez Firestore
      title: title,
      description: description,
      date: date,
      location: location,
      participants: [],
    );

    await _firestoreService.addEvent(newEvent);
  }

  Future<void> toggleUserParticipation(Event event, String uid) async {
    final isJoining = !event.participants.contains(uid);
    await _firestoreService.toggleParticipation(event.id, uid, isJoining);
  }
}
