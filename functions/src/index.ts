import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { Email } from './services/email';
admin.initializeApp();
// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
export const sendWelcomeEmail = functions.auth.user().onCreate(user => {
    const email: string = user.email;
    const displayName: string = user.displayName;
    console.log(email, displayName);
    const emailClass = new Email(email, displayName);
    return {
        email: email,
        displayname: displayName
    };
});