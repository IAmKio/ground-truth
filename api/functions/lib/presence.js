const functions = require('firebase-functions');
const admin = require('firebase-admin');

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

  await db.collection('presences')
  .doc(request.body.uid)
  .set({
    anonymousUserId: request.body.uid,
    fcmToken: request.body.fcmToken,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  })
  .then((snapshot) => {
    console.log('Successfully stored presence:', snapshot);
  });

  console.log('Presence recorded.');

 return response.send('OK');
});

module.exports = request;