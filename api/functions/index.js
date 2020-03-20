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

const ingest = require('./lib/ingest');
const layers = require('./lib/layers');
const presences = require('./lib/presence');
const hotspots = require('./lib/hotspots');
const statistics = require('./lib/statistics');
const announcements = require('./lib/announcements');

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
exports.announcements = announcements;
