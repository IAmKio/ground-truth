const functions = require('firebase-functions');
const admin = require('firebase-admin');
const geohash = require('ngeohash');

try {
  admin.initializeApp();
} catch (e) {
  console.error('Workaround fired:', e);
}

let db = admin.firestore();

const request = functions.https.onRequest(async (request, response) => {
  console.log('Incoming data:', {
    body: request.body,
    query: request.query,
  });

  const hotspotReference = await db.collection('hotspots').doc().set({
    anonymousUserId: request.body.anonymousUserId,
    geopoint: new admin.firestore.GeoPoint(
      parseFloat(request.body.latitude),
      parseFloat(request.body.longitude)
    ),
    geohash: geohash.encode(
      parseFloat(request.body.latitude),
      parseFloat(request.body.longitude)
    ),
    layerId: request.body.layerId,
    notes: [],
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  })
  .then((writeResult) => {
    console.log('Successfully wrote hotspot:', writeResult);
  });

db.collection('statistics').doc('hotspots')
  .update("submissionCount", admin.firestore.FieldValue.increment(1));

console.log('Ingestion complete.')

 return response.send({
   hotspotReference
 });
});

module.exports = request;