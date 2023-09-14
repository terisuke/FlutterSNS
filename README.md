# udemy_flutter_sns

A new Flutter project.
// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyBWx92_9RN_PfAtoo8hftqw7rC4Bwx-w9A",
  authDomain: "fir-flutter-77794.firebaseapp.com",
  databaseURL: "https://fir-flutter-77794-default-rtdb.asia-southeast1.firebasedatabase.app",
  projectId: "fir-flutter-77794",
  storageBucket: "fir-flutter-77794.appspot.com",
  messagingSenderId: "488478065875",
  appId: "1:488478065875:web:ae6b4d404f9455f186c026",
  measurementId: "G-N1D1J4HQRV"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);