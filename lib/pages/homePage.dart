import 'package:chatting/components/my_drawer.dart';
import 'package:chatting/components/usertile.dart';
import 'package:chatting/pages/chatPage.dart';
import 'package:chatting/services/auth/auth_service.dart';
import 'package:chatting/services/chat/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  //geting the chat and the auth service
  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? getcurrentUser() {
    return auth.currentUser;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),//to set icon color

        title: Text("Home",style: TextStyle(color: Theme.of(context).colorScheme.primary),),

        backgroundColor: Colors.transparent,
        ),
        drawer:my_drawer(),
        body: userlist(),//defined below to keeo the code clean
    );
  }
  Widget userlist() {
     return StreamBuilder(
      stream: chatService.getUserStream(),
      builder: (context, snapshot){
        //errors
        if(snapshot.hasError){
          return Center(
            child: Text("Error: ${snapshot.error}"),
          ); 
        }
        //loading..
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: const Text("loading...."));
        }
        //return the list view

        return ListView(
          children: snapshot.data!.map<Widget>((userData) => builduseritem(userData, context)).toList(),
        );
      }
     );
  }
  Widget builduseritem(Map<String,dynamic> userData, BuildContext context) {
    if(userData["email"] != getcurrentUser()!.email)
    {
      return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 5,bottom: 5,left: 15,right: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Usertile(
        text: userData["email"],
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(reciverEmail: userData["email"],revicerid: userData["uid"],)));
        }),
      );
    }
    else{
      return Container();
    }
  }
} 