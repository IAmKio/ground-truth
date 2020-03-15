const functions = require('firebase-functions');
const admin = require('firebase-admin');

const mappedLayerData = [];

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

  const layerData = await db.collection('layers').get()
  .then((snapshot) => {
    console.log('Successfully get layers:', snapshot);

    return snapshot;
  });

  console.log('Layer read complete.');

  mappedLayerData = layerData.docs.map((thisLayerData) => thisLayerData.data());

 return response.send({
   layers: mappedLayerData
 });
});

module.exports = request;