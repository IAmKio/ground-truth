const functions = require('firebase-functions');

const request = functions.https.onRequest((request, response) => {
 response.send({
   body: request.body,
   query: request.query,
 });
});

module.exports = request;