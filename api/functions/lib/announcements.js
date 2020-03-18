const functions = require('firebase-functions');
const admin = require('firebase-admin');

let mappedAnnouncementsData = [];

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

  const annoucementsData = await db.collection('annoucements').get()
  .then((snapshot) => {
    console.log('Successfully got Announcements:', snapshot);

    return snapshot;
  });

  console.log('Announcements read complete.');

  mappedAnnouncementsData = annoucementsData.docs.map((thisannoucementsData) => thisannoucementsData.data());

  return response.send({
    announcements: mappedAnnouncementsData
  });
});

module.exports = request;