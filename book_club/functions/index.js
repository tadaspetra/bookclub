const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();
const database = admin.firestore();

exports.checkForBookTransition = functions.pubsub.schedule('every 1 hour').onRun(async (context) => {
    const query = await database.collection("groups")
        .where("currentBookDue", '<=', admin.firestore.Timestamp.now())
        .get();
    query.forEach(async eachGroup => {
        var currentIndex = eachGroup.data()["indexPickingBook"];
        var totalMembers = eachGroup.data()["members"].length;
        var nextIndex;

        if (currentIndex >= (totalMembers - 1)) {
            nextIndex = 0;
        } else {
            nextIndex = currentIndex + 1;
        }

        await database.doc('groups/' + eachGroup.id).update({
            "currentBookDue": eachGroup.data()["nextBookDue"],
            "currentBookId": eachGroup.data()["nextBookId"],
            "nextBookId": "waiting",
            "indexPickingBook": nextIndex,
        })
    })
})
