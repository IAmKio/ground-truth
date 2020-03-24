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
const geohash = require('ngeohash');

try {
  admin.initializeApp();
} catch (e) {
  console.error('Workaround fired:', e);
}

let db = admin.firestore();

const request = functions.https.onRequest(async (request, response) => {
  console.log('Incoming data:', {
    headers: request.headers,
    body: request.body,
    query: request.query,
  });

  response.set('Access-Control-Allow-Origin', '*');
  response.set('Access-Control-Allow-Methods', 'GET, PUT, POST, OPTIONS');
  response.set('Access-Control-Allow-Headers', '*');
  
  if (req.method === 'OPTIONS') {
    response.end();
  }

  const hotspotReference = await db.collection('hotspots').doc().set({
    anonymousUserId: request.body.anonymousUserId,
    geopoint: new admin.firestore.GeoPoint(
      parseFloat(request.body.latitude),
      parseFloat(request.body.longitude)
    ),
    geohash: geohash.encode(
      parseFloat(request.body.latitude),
      parseFloat(request.body.longitude)
    ),
    layerId: request.body.layerId,
    notes: [],
    observed: false,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  })
  .then((writeResult) => {
    console.log('Successfully wrote hotspot:', writeResult);
  });

  db.collection('statistics').doc('hotspots')
    .update("count", admin.firestore.FieldValue.increment(1));

  console.log('Ingestion complete.')

  response.send({
    hotspotReference
  });
});

module.exports = request;