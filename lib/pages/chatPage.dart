import 'package:chatting/components/my_textfeil.dart';
import 'package:chatting/services/auth/auth_service.dart';
import 'package:chatting/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String reciverEmail;
  final String revicerid;
   ChatPage({
    super.key,
    required this.reciverEmail,
    required this.revicerid,
    });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
    //creating a focus node
    final FocusNode _focusNode = FocusNode();
    //test controller for the message
    final textController = TextEditingController();

    //getting the chat and auth services
    final chatService = ChatService();

    final authService = AuthService();

    @override
    void initState() {
      super.initState();
      //request focus on the text field
      _focusNode.addListener((){
        if(_focusNode.hasFocus){
          //request focus on the text field
          Future.delayed(Duration(milliseconds: 100),()=>scrollDown());
          FocusScope.of(context).requestFocus(_focusNode);
        }
      });
    }
    void dispose() {
      // Dispose of the focus node when the widget is disposed
      _focusNode.dispose();
      textController.dispose();
      super.dispose();
    }

    //send message
    void sendmessage() async{
      if(textController.text.isNotEmpty){
        await chatService.sendMessage(widget.revicerid, textController.text);
        //print(textController.text);
        textController.clear();
      }
    }

    //scroll controller
    final ScrollController _scrollController = ScrollController();
    void scrollDown() {
      // Scroll to the bottom of the list
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        title: Text(widget.reciverEmail,style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(child: buidmessagelist())
          //user input
          ,SizedBox(height: 10,),
          buildInput(context),
        ],
      ),
    );
  }

  Widget buidmessagelist()
  {
    return StreamBuilder(
      stream:chatService.getMessages(widget.revicerid),//should i add senderid in the pameters? i did not at this moment since we are already inatialization it in the chatservice method 
    
      builder: (context,snaphot){
        if(snaphot.hasError)
        {
          return Center(child: Text("Error: ${snaphot.error}"),);
        }
        if(snaphot.connectionState==ConnectionState.waiting)
        {
          return Center(child: CircularProgressIndicator(),);
        }
        if(snaphot.hasData)//go back to 48:00 if there are any errors
        {
          WidgetsBinding.instance.addPostFrameCallback((_) => scrollDown());
          return ListView(
            controller: _scrollController,
            children: snaphot.data!.docs.map((doc) => buildMessageItem(doc)).toList(),
          );
        }
        return Center(child: Text("No messages"),);
      },
      );
  }

  //build message item
 Widget buildMessageItem(doc) {
  Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  bool isSender = data['senderId'] == authService.getCurrentUser()!.uid;
 
  print(data['message']);
  return Align(
    alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: isSender ? Colors.green : Colors.blue,
       borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: isSender ? Radius.circular(10) : Radius.circular(0),
        bottomRight: isSender ? Radius.circular(0) : Radius.circular(10),
       )
        //borderRadius: BorderRadius.circular(5),
      ),
      child: Text(data['message'], style: TextStyle(color: Colors.white),),
    ),
  );
}

  //build user input
  Widget buildInput(BuildContext context){
    return Container(
      //color: Theme.of(context).colorScheme.primary,
      child: Row(
        children: [
          Expanded(
            child:Mytextfeild(hint: "Type a Message", isPassword: false, controller: textController, focusNode: _focusNode,)
            ),
            IconButton(
              onPressed: sendmessage,
              icon: Icon(Icons.send,color: Theme.of(context).colorScheme.primary, size: 30,),
            ),
        ],
        ),
    );
  }
}