// Copyright 2020 Kieran Goodary, Digital Industria Ltd
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
//     http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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