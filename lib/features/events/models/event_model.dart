import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String location;
  final List<String> participants;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.participants,
  });

  factory Event.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Event(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      location: data['location'] ?? '',
      participants: List<String>.from(data['participants'] ?? []),
    );
  }

  factory Event.fromJson(Map<String, dynamic> json, String documentId) {
    return Event(
      id: documentId,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      date: (json['date'] as Timestamp).toDate(),
      location: json['location'] ?? '',
      participants: List<String>.from(json['participants'] ?? []),
    );
  }
}
