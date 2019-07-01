import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { Email } from './services/email';
admin.initializeApp();
// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
export const sendWelcomeEmail = functions.auth.user().onCreate(user => {
    let email: string = user.email;
    let displayName: string = user.displayName;
    const emailClass = new Email(email, displayName);
    return emailClass.sendEmail();
});