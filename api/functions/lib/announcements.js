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

let mappedAnnouncementsData = [];

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

  const announcementsData = await db.collection('announcements').get()
  .then((snapshot) => {
    console.log('Successfully got Announcements:', snapshot);

    return snapshot;
  });

  console.log('Announcements read complete.');

  mappedAnnouncementsData = announcementsData.docs.map((thisannouncementsData) => thisannouncementsData.data());

  return response.send({
    announcements: mappedAnnouncementsData
  });
});

module.exports = request;