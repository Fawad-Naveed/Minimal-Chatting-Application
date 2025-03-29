import 'package:chatting/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {

  //instance of the firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get user stream to diplay all the avaliable users
  /*
  List<Map<String,dynamic>>
  [
    {
      'eamil': mail of the user 1
      'name': name of the user 1
    }
    {
      'eamil': mail of the user 2
      'name': name of the user 2
    }
  ]
  and wil be returning the stream that means that we will be listing to the fire store
   */


  Stream<List<Map<String,dynamic>>>  getUserStream() {
    return _firestore.collection('Users').snapshots().map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
  //send message to the user
  Future<void> sendMessage(String revicerid,message) async{
    //get the current/sender user id
    String senderId = _auth.currentUser!.uid;
    String senderEmail=_auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message _message = Message(
    senderId: senderId,
    senderEmail: senderEmail,
    receiverId: '',
    message: message,
    timestamp: timestamp);

    //create messages

    List<String> ids = [senderId,revicerid];
    ids.sort();
    String chatRoomId=ids.join('_');

    await _firestore.collection("Chat_rooms").doc(chatRoomId).collection("messages").add(_message.toMap());


  }
  //get messages from the user

  Stream<QuerySnapshot> getMessages(String receiverId) {
    String senderId = _auth.currentUser!.uid;
    List<String> ids = [senderId,receiverId];
    ids.sort();
    String chatRoomId=ids.join('_');
    return _firestore.collection("Chat_rooms").doc(chatRoomId).collection("messages").orderBy('timestamp',descending: false).snapshots();
  }


}