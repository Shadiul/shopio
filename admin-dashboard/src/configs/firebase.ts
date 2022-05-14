import firebase from "firebase/compat/app";
import "firebase/compat/auth";
import "firebase/compat/firestore";
import "firebase/compat/storage";

const firebaseConfig = {
  apiKey: "AIzaSyCLusD5CSB1BTJJ_vaV2X8lp7fn5Mm0uMI",
  authDomain: "shopio-031.firebaseapp.com",
  projectId: "shopio-031",
  storageBucket: "shopio-031.appspot.com",
  messagingSenderId: "885510524271",
  appId: "1:885510524271:web:346f7fa64921e25f20ec9a",
  measurementId: "G-DG7EBMFCYG",
};

if (!firebase.apps.length) {
  firebase.initializeApp(firebaseConfig);
}

export const auth = firebase.auth();
export const firestore = firebase.firestore();
export const storage = firebase.storage();
