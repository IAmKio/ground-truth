const functions = require('firebase-functions');
const admin = require('firebase-admin');

var serviceAccount = require("../keys/wearequarantined-firebase-adminsdk-cez2w-3d829c6054.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: 'https://wearequarantined.firebaseio.com'
});

exports.default = functions.https.onRequest((request, response) => {
 response.send('OK');
});
