const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

// Create Event
exports.createEvent = functions.https.onRequest(async (req, res) => {
  try {
    const data = req.body;
    const event = {
      title: data.title,
      description: data.description,
      date: admin.firestore.Timestamp.fromDate(new Date(data.date)),
      location: data.location,
      organizer: data.organizer,
      eventType: data.eventType,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };
    await admin.firestore().collection("events").add(event);
    res.status(201).send("Event Created Successfully");
  } catch (error) {
    res.status(500).send(`Error creating event: ${error.message}`);
  }
});

// Get All Events
exports.getAllEvents = functions.https.onRequest(async (req, res) => {
  try {
    const eventsSnapshot = await admin.firestore().collection("events").get();
    const events = eventsSnapshot.docs.map((doc) => doc.data());
    res.status(200).json(events);
  } catch (error) {
    res.status(500).send(`Error fetching events: ${error.message}`);
  }
});

// Filter Events by Type
exports.filterEvents = functions.https.onRequest(async (req, res) => {
  try {
    const eventType = req.query.type;
    const eventsSnapshot = await admin
      .firestore()
      .collection("events")
      .where("eventType", "==", eventType)
      .get();
    const events = eventsSnapshot.docs.map((doc) => doc.data());
    res.status(200).json(events);
  } catch (error) {
    res.status(500).send(`Error filtering events: ${error.message}`);
  }
});
