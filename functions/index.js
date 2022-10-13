const functions = require('firebase-functions')
const admin = require('firebase-admin')
admin.initializeApp()

exports.sendNotification = functions.firestore
  .document('chatroom/{chatId}/chats/{message}')
  .onCreate((snap) => {
    console.log('----------------start function--------------------')

    const doc = snap.data()
   

    const idFrom = doc.idFrom
    const idTo = doc.idTo
    const contentMessage = doc.message

    console.log(`Starting to push token`)
    // Get push token user to (receive)
    admin
      .firestore()
      .collection('users')
      .where('uid', '==', idTo)
      .get()
      .then(querySnapshot => {
        querySnapshot.forEach(userTo => {
          console.log(`Found user to: ${userTo.data().name}`)
          console.log(`Found user to: ${userTo.data().pushtoken}`)
          try {
            // Get info of the user who is sending the message
            admin
              .firestore()
              .collection('users')
              .where('uid', '==', idFrom)
              .get()
              .then(querySnapshot2 => {
                querySnapshot2.forEach(userFrom => {
                  console.log(`Found user from: ${userFrom.data().name}`)
                  const payload = {
                    notification: {
                      title: `${userFrom.data().name}`,
                      body: `${contentMessage}`,
                      badge: '1',
                      sound: 'default'
                    }
                  }
                  
                  // Let push to the target device
                  admin
                    .messaging()
                    .sendToDevice(userTo.data().pushtoken, payload)
                    .then(response => {
                      console.log('Successfully sent message:', response)
                    })
                    .catch(error => {
                      console.log('Error sending message:', error)
                    })
                })
              })
          } catch(e){
            console.log('Can not find pushToken target user')
          }
        })
      })
    return null
  })