import 'package:chatting/pages/loginpage.dart';
import 'package:chatting/pages/registrationpage.dart';
import 'package:flutter/material.dart';

class LoginOrReg extends StatefulWidget {
  const LoginOrReg({super.key});

  @override
  State <LoginOrReg> createState() =>  LoginOrRegState();
}

class  LoginOrRegState extends State <LoginOrReg> {


  bool show_login_page=true;


  void toggle(){
    setState(() {
      show_login_page=!show_login_page;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(show_login_page){
      return Loginpage(ontap: toggle);
    }else{ 
      return Registrationpage(ontap: toggle);
    }
  }
}