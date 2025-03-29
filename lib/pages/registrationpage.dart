import 'package:chatting/services/auth/auth_service.dart';
import 'package:chatting/components/my_textfeil.dart';
import 'package:flutter/material.dart';


class Registrationpage extends StatelessWidget {
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  final TextEditingController conpasswordController=TextEditingController();
  Registrationpage({super.key,required this.ontap});



  final void Function()? ontap;
  //Register function
  void Register(BuildContext context) async{
    final String email=emailController.text;
    final String password=passwordController.text;
    final String conpassword=conpasswordController.text;
    //passwords math we can create the user 
    if(password==conpassword){
      try{
        final _auth=AuthService();
        _auth.signUpWithEmailAndPassword(email, password,context);
      }catch(e){
        showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
      }
    }//if the password do not match we can show the warning 
    else{
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Passwords do not match"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
              children: [
                Icon(
                Icons.all_inclusive_outlined,
                size: 40,
                color: Theme.of(context).colorScheme.primary,
                ),
                //welcome back message
                Text("Sure, Let's get you started"),
              ],
              ),
            ),
            //email text feild
            Mytextfeild(
              hint:"Email",
              isPassword: false,
              controller: emailController,),
            //password text feild
            Mytextfeild(
              hint:"Password",
              isPassword:true,
              controller: passwordController,),
              //confirm password text feild
              Mytextfeild(
              hint:"Confirm Password",
              isPassword:true,
              controller: conpasswordController,),
            //login button
            //login button

            SizedBox(
              width: 340,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Theme.of(context).colorScheme.primary,
                    foregroundColor:  Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // Removes the border radius
                    ),
                  ),
                  onPressed: () => Register(context),
                  child: const Text("Register"),
                ),
            ),
            //register text
            GestureDetector(
              onTap:ontap,
              child: Padding(padding: const EdgeInsets.all(8.0),
                  child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? ",style: TextStyle(color:Theme.of(context).colorScheme.primary),),
                    Text("Login Now",style: TextStyle(fontWeight:FontWeight.bold,color:Theme.of(context).colorScheme.primary),),
                  ],
                )
              ),
            )
          ],
        ),
      )
    );
  }
}