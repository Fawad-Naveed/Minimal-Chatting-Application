import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {

  //instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // sign in
  Future<UserCredential> signInWithEmailAndPassword(String email, password) async {
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password,);
       _firestore.collection('Users').doc(userCredential.user!.uid).set({
        'email': email,
        'uid': userCredential.user!.uid,
      });
      return userCredential;
    } on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }
  // sign up
  Future<UserCredential>signUpWithEmailAndPassword(String email, String password,BuildContext context) async
  {
    try{
      UserCredential userCredential=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      // save the user data to the firestore
      _firestore.collection('Users').doc(userCredential.user!.uid).set({
        'email': email,
        'uid': userCredential.user!.uid,
      });
      return userCredential;

    } on FirebaseAuthException catch(e){
      showDialog(context: context, builder: (context) => AlertDialog(title: Text(e.code),));
      throw Exception(e.code);
    }
  }
  //sign out
  Future<void> signOut() async {
    await _auth.signOut();
  } //future<void> means it returns nothing and may return something in the future

  //errorsfz
  User ? getCurrentUser() {
    return _auth.currentUser;
  }
}