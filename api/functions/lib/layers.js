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

  const layerData = await db.collection('layers').get()
  .then((readResult) => {
    console.log('Successfully get layers:', readResult);
    return layerData.data();
  });

  console.log('Layer read complete.');

 return response.send({
   layers: layerData
 });
});

module.exports = request;