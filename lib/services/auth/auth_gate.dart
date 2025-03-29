import 'package:chatting/services/auth/login_or_reg.dart';
import 'package:chatting/pages/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot) {
          //logged in
          if(snapshot.hasData)
          {
            return HomePage();
            //return LoginOrReg();
          }
          else {
            return LoginOrReg();
          }
        }
        ),
    );
  }
}