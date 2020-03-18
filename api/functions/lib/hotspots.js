const functions = require('firebase-functions');
const admin = require('firebase-admin');

let mappedHotspotData = [];

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

  const hotspotData = await db.collection('hotspots').get()
  .then((snapshot) => {
    console.log('Successfully got hotspots:', snapshot);

    return snapshot;
  });

  console.log('Hotspot read complete.');

  mappedHotspotData = hotspotData.docs.map((thishotspotData) => {
    const hotspotObject = {
      hotspotId: thishotspotData.id,
      ...thishotspotData.data()
    }
    
    return hotspotObject;
  });

  await db
    .collection('statistics')
    .doc('mapBrowserViews')
    .update("count", admin.firestore.FieldValue.increment(1));

 return response.send({
   hotspots: mappedHotspotData
 });
});

module.exports = request;