const functions = require('firebase-functions');
const admin = require('firebase-admin');

let mappedStatisticsData = [];

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

  const statisticsData = await db.collection('statistics').get()
  .then((snapshot) => {
    console.log('Successfully got statistics:', snapshot);

    return snapshot;
  });

  console.log('Statistics read complete.');

  mappedStatisticsData = statisticsData.docs.map((thisstatisticsData) => thisstatisticsData.data());

  return response.send({
    statistics: mappedStatisticsData
  });
});

module.exports = request;