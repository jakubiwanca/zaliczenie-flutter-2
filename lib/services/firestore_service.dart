import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/events/models/event_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Event>> getEventsStream() {
    return _db.collection('events').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Event.fromJson(data, doc.id);
      }).toList();
    });
  }

  Future<int> getNextEventId() async {
    final snapshot = await _db.collection('events').get();
    // Pobierz maksymalny ID z dokumentów (jeśli są puste, zwróć 1)
    int maxId = 0;
    for (var doc in snapshot.docs) {
      final data = doc.data();
      int id = 0;
      if (data.containsKey('id')) {
        id = (data['id'] is int) ? data['id'] : int.tryParse(data['id'].toString()) ?? 0;
      }
      if (id > maxId) maxId = id;
    }
    return maxId + 1;
  }

  Future<void> addEvent(Event event) async {
    final newId = await getNextEventId();
    await _db.collection('events').doc(newId.toString()).set({
      'id': newId,
      'title': event.title,
      'description': event.description,
      'date': Timestamp.fromDate(event.date),
      'location': event.location,
      'participants': [],
    });

  }

  Future<void> toggleParticipation(String eventId, String uid, bool join) async {
    final eventRef = _db.collection('events').doc(eventId);
    final update = join
        ? FieldValue.arrayUnion([uid])
        : FieldValue.arrayRemove([uid]);

    await eventRef.update({'participants': update});
  }

}
