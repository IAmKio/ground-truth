const functions = require('firebase-functions');
const admin = require('firebase-admin');

const ingest = require('./lib/ingest');
const layers = require('./lib/layers');
const presences = require('./lib/presence');
const hotspots = require('./lib/hotspots');
const statistics = require('./lib/statistics');
const annoucements = require('./lib/announcements');

let serviceAccount = null;

try {
  serviceAccount = require("../keys/wearequarantined-firebase-adminsdk-cez2w-3d829c6054.json");
  console.log('🔎 Found a service account key file.');
} catch (e) {
  console.log('⚠️ Could not find key file - assuming Firebase Functions environment.');
}

if (serviceAccount) {
  try {
    admin.initializeApp({
      credential: admin.credential.cert(serviceAccount),
      databaseURL: 'https://wearequarantined.firebaseio.com',
    });
  } catch (e) {
    console.error('Cought init error:', e);
  }

  console.log('⚡️ Initialised app using credentials file.');
} else {
  try {
    admin.initializeApp();
  } catch(e) {
    console.error('Cought init error:', e);
  }

  console.log('️️️⚡️ Initialised app manually.');
}

exports.default = functions.https.onRequest((request, response) => {
 response.send('OK');
});
exports.ingest = ingest;
exports.layers = layers;
exports.presences = presences;
exports.hotspots = hotspots;
exports.statistics = statistics;
exports.annoucements = annoucements;
