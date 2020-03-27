const functions = require('firebase-functions');
const admin = require('firebase-admin');

try {
  admin.initializeApp();
} catch (e) {
  console.error('Workaround fired:', e);
}

let db = admin.firestore();

exports.scheduledFunctionCrontab = functions.pubsub.schedule('0 0 * * *')
  .timeZone('Etc/GMT')
  .onRun((context) => {
    console.log('Firing nightly.')
    /**
     * TODO: Nightly CSV dump to Firestore.
     */
  return null;
});