import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Event List')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('events').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          var events = snapshot.data.docs;
          
          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              var event = events[index];
              return ListTile(
                title: Text(event['title']),
                subtitle: Text(event['eventType']),
                onTap: () {
                  // Navigate to event detail screen
                },
              );
            },
          );
        },
      ),
    );
  }
}
