// The Cloud Functions for Firebase SDK to create Cloud Functions and set up triggers.
const functions = require("firebase-functions");

// The Firebase Admin SDK to access Firestore.
const admin = require('firebase-admin');
const axios = require('axios');
admin.initializeApp();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
exports.helloWorld = functions.https.onRequest((request, response) => {
  functions.logger.info("Hello logs!", { structuredData: true });
  response.send("Hello from Firebase!");
});

// Take the text parameter passed to this HTTP endpoint and insert it into 
// Firestore under the path /messages/:documentId/original
exports.addMessage = functions.https.onRequest(async (req, res) => {
  // Grab the text parameter.
  const original = req.query.text;
  // Push the new message into Firestore using the Firebase Admin SDK.
  const writeResult = await admin.firestore().collection('messages').add({ original: original });
  // Send back a message that we've successfully written the message
  res.json({ result: `Message with ID: ${writeResult.id} added.` });
});


// Listens for new messages added to /messages/:documentId/original and creates an
// uppercase version of the message to /messages/:documentId/uppercase
exports.makeUppercase = functions.firestore.document('/messages/{documentId}')
  .onCreate((snap, context) => {
    // Grab the current value of what was written to Firestore.
    const original = snap.data().original;

    // Access the parameter `{documentId}` with `context.params`
    functions.logger.log('Uppercasing', context.params.documentId, original);

    const uppercase = original.toUpperCase();

    // You must return a Promise when performing asynchronous tasks inside a Functions such as
    // writing to Firestore.
    // Setting an 'uppercase' field in Firestore document returns a Promise.
    return snap.ref.set({ uppercase }, { merge: true });
  });

exports.getGoogleNearby = functions.firestore.document('/Coordinates/{documentId}')
  .onCreate((snap, context) => {
    const lat = snap.data().latitude;
    const long = snap.data().longitude;
    const radius = 1500;
    const key = "AIzaSyBedDUKU41U3bxNlZwOy7uqW9xyudEIr1w";
    var config = {
      method: 'get',
      url: `https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${lat}%2C${long}&radius=${radius}&key=${key}`,
      // params: {
      //   location: lat + '%2C' + long,
      //   radius: 1500,
      //   key: 'AIzaSyBedDUKU41U3bxNlZwOy7uqW9xyudEIr1w'
      // },
      headers: { }
    };

    return axios(config)
      .then(response => {
        const places = JSON.stringify(response.data);
        console.log(places);
        functions.logger.log('Places', context.params.documentId, places);
        return snap.ref.set({ places }, { merge: true });
      })
      .catch(error => {
        console.log(error);
        return callback(new Error("Error getting google directions"))
      });

    // axios({
    //   method: 'GET',
    //   url: 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?', //https://maps.googleapis.com/maps/api/directions/json',
    //   params: {
    //     location: lat + "%" + long,
    //     radius: "100",
    //     key: 'AIzaSyBedDUKU41U3bxNlZwOy7uqW9xyudEIr1w'
    //   },
    // })
    //   .then(response => {
    //     let legs = response.data.routes[0].legs[0];
    //     return callback(legs);
    //   })
    //   .catch(error => {
    //     console.log('Failed calling Nearby API');
    //     return callback(new Error("Error getting Google Places Nearby Search"))
    //   })
  });