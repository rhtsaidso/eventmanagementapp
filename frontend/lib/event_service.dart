import 'package:cloud_firestore/cloud_firestore.dart';

class EventService {
  final CollectionReference eventCollection =
      FirebaseFirestore.instance.collection('events');

  Stream<List<Event>> getEvents() {
    return eventCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Event.fromFirestore(doc)).toList();
    });
  }
}

class Event {
  final String title;
  final String description;
  final DateTime date;
  final String location;
  final String organizer;
  final String eventType;

  Event({this.title, this.description, this.date, this.location, this.organizer, this.eventType});

  factory Event.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return Event(
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      location: data['location'] ?? '',
      organizer: data['organizer'] ?? '',
      eventType: data['eventType'] ?? ''
    );
  }
}
